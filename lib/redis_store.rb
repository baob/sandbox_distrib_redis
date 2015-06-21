require_relative 'redis_store/integer_store'
require_relative 'redis_store/integer_queue'
require_relative 'redis_store/primes_list'

module RedisStore

  def self.consecutive_primes_list(value = nil, opts = {})
    Storage::ConsecutivePrimesList.new(value, opts.merge(storage_model: RedisStore))
  end

  def self.integer(number, opts = {})
    IntegerStore.new(number, opts)
  end

  def self.integer_queue(value = nil, opts = {})
    IntegerQueue.new(value, opts)
  end

  def self.primes_list(value = nil, opts = {})
    PrimesList.new(value, opts)
  end

end
