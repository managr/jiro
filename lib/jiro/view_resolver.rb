module Jiro
  class ViewResolver < ::ActionView::FileSystemResolver

    def initialize
      super('app/views')
    end

    def find_templates(name, prefix, partial, details)
      view_key = {
        :name     => name,
        :prefix   => prefix,
        :partial  => partial,
        :locale   => details[:locale],
        :format   => details[:formats],
        :handler  => details[:handler]
      } 

      persisted = RedisConnection.get.hget(Jiro.app_id, view_key)
      return YAML::load(persisted) if persisted

      from_file_system = super(name, prefix, partial, details)
      RedisConnection.get.hset(Jiro.app_id, view_key, YAML::dump(from_file_system)) unless from_file_system.empty?
      from_file_system
    end

  end
end
