require "redis"

module Jiro
  module RedisConnection
    def get
      @redis_connection ||= Redis.new(Jiro.configuration.redis_opts)
    end
 
    extend self
  end
end
