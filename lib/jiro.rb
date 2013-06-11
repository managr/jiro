require 'jiro/redis_connection'
require 'jiro/view_resolver'

module Jiro
  module AppId
    def app_id
      defined?(@app_id) ? @app_id : Jiro.app_id
    end

    def app_id=(id)
      @app_id = id
    end
  
    def redis_opts
      defined?(@redis_opts)? @redis_opts : Jiro.redis_opts
    end

    def redis_opts=(opts)
      @redis_opts = opts
    end
  end

  extend AppId

  self.app_id = "jiro_cms_pages"
  self.redis_opts = {}
end
