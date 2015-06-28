require 'redis'

module RedisStore
  class IntegerQueue

    attr_reader :store_name

    def initialize(value = nil, opts = {})
      @store_name = opts[:id] || 'integer_queue'
      redis.del(store_name)
      unless value.nil?
        value.each { |v| self << v }
      end
    end

    def <<(elem)
      redis.rpush(store_name, elem)
    end

    def count
      redis.llen(store_name)
    end

    def empty?
      count == 0
    end

    def to_a
      redis.lrange(store_name, 0, -1).map(&:to_i)
    end

    def sort
      redis.lrange(store_name, 0, -1).map(&:to_i).sort
    end

    def pop
      redis.lpop(store_name).to_i
    end

    def last
      return nil if empty?
      redis.zrange(store_name, -1, -1).first.to_i
    end
    alias_method :max, :last

    def [](index)
      return nil if empty?
      redis.zrange(store_name, index, index).first.to_i
    end

    private

    def redis
      @redis ||= Redis.new
    end

  end
end
