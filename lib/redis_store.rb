require_relative 'redis_store/integer_store'
require_relative 'redis_store/integer_queue'
require_relative 'redis_store/primes_list'

module RedisStore

  def self.consecutive_primes_list(opts = {})
    Storage::ConsecutivePrimesList.new(opts.merge(storage_model: RedisStore))
  end

  def self.integer(number, opts = {})
    IntegerStore.new(number, opts)
  end

  def self.integer_queue(opts = {})
    IntegerQueue.new(opts)
  end

  def self.primes_list(opts = {})
    PrimesList.new(opts)
  end

end
