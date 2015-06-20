require_relative 'storage/integer_store'
require_relative 'storage/integer_queue'
require_relative 'storage/primes_list'

module MemoryStore

  def self.integer(number, opts = {})
    Storage::IntegerStore.new(number, opts)
  end

  def self.integer_queue(opts = {})
    Storage::IntegerQueue.new(opts)
  end

  def self.primes_list(opts = {})
    Storage::PrimesList.new(opts)
  end

end
