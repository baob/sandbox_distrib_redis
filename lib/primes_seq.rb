require_relative 'storage/primes_list'
require_relative 'primes'

class PrimesSeq
  include Primes

  attr_reader :storage_model

  def initialize(opts = {})
    @model = opts[:model] || Storage::PrimesList
    @storage_model = opts[:storage_model] || MemoryStore
  end

  def run(count)
    @primes = @model.new(storage_model: storage_model)
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = storage_model.integer(count, id: :input_count)

    test = @primes.to_a.last + 1
    until have_enough_results?
      make_new_test(test)
      test += 1
    end

    @primes.to_a
  end

  def make_new_test(test)
    test_result = is_prime?(test)
    store_result(test_result, test)
  end

end
