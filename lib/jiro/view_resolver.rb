module Jiro
  class ViewResolver < ::ActionView::FileSystemResolver

    def initialize
      super('app/views')
    end

    def find_templates(name, prefix, partial, details)
      view_key = build_view_key(name, prefix, partial, details)

      if persisted = RedisConnection.get.hget(Jiro.configuration.app_id, view_key)
        Rails.logger.debug "Returning persisted page from redis (#{view_key})"
        begin
          return Marshal::load(persisted).map { |p|
            build_templates(p)
          }
        rescue
          Rails.logger.debug "Removing object that cannot be loaded (#{view_key})"
          RedisConnection.get.hdel(Jiro.app_id, view_key)
        end
      end
      
      from_file_system = super(name, prefix, partial, details)
      
      unless from_file_system.empty?
        Rails.logger.debug "Caching from file system #{from_file_system.inspect}"

        RedisConnection.get.hset(Jiro.app_id, view_key, Marshal::dump(from_file_system.map { |template|
          build_templates_hash(template)
        }))
      end
      from_file_system
    end

    private

    def build_view_key(name, prefix, partial, details)
      {:name     => name,
        :prefix   => prefix,
        :partial  => partial,
        :locale   => details[:locale],
        :format   => details[:formats],
      :handler  => details[:handler]}
    end

    def build_templates(p)
      ActionView::Template.new(p[:source], p[:identifier], p[:handler],
      { :format => p[:formats].first, :locals => p[:locals], :virtual_path => p[:virtual_path], :updated_at => p[:updated_at] })

    end

    def build_templates_hash(template)
      {
        :source => template.source,
        :identifier => template.identifier,
        :handler => template.handler,

        :formats => template.formats,
        :locals => template.locals,
        :virtual_path => template.virtual_path,
        :updated_at => template.updated_at
      }
    end
  end
end
