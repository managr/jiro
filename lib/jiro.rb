require 'jiro/redis_connection'
require 'jiro/view_resolver'

module Jiro
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :app_id
    attr_accessor :redis_opts
    attr_accessor :limit_to_handlers

    def initialize
      @app_id = 'jiro_cms_pages'
      @redis_opts = {}
      @limit_to_handlers = nil
    end
  end
end

Jiro.configure do |c|
  # empty configuration called to initialize
end