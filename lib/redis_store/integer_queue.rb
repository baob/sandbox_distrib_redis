require 'redis'

module RedisStore
  class IntegerQueue

    attr_reader :store_name

    def initialize(opts = {})
      @store_name = opts[:id] || 'integer_queue'
      redis.del(store_name)
    end

    def <<(elem)
      redis.zadd(store_name, elem, elem.to_s)
    end

    def count
      redis.zcard(store_name)
    end

    def empty?
      count == 0
    end

    def to_a
      sort
    end

    def sort
      redis.zrange(store_name, 0, -1).map(&:to_i)
    end

    def min
      return nil if empty?
      redis.zrange(store_name, 0, 0).first.to_i
    end

    def delete(elem)
      redis.zrem(store_name, elem.to_s)
    end

    def include?(elem)
      !redis.zrank(store_name, elem.to_s).nil?
    end

    private

    def redis
      @redis ||= Redis.new
    end

  end
end
