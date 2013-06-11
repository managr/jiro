require "redis"

module Jiro
  module RedisConnection
    def get
      @redis_connection ||= Redis.new(Jiro.redis_opts)
    end
 
    extend self
  end
end
