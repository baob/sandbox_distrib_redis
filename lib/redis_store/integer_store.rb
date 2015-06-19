require 'redis'

module RedisStore
  class IntegerStore

    attr_reader :store_name

    def initialize(number, opts = {})
      @store_name = opts[:id] || 'integer_store'
      redis.set(store_name, number.to_s)
    end

    def redis
      @redis ||= Redis.new
    end

    def set(number)
      redis.set(store_name, number.to_s)
    end

    def to_i
      redis.get(store_name).to_i
    end

  end
end
