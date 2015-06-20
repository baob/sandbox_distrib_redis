require_relative 'storage/consecutive_primes_list'
require_relative 'storage/primes_list'
require_relative 'primes'

class PrimesRecurse
  include Primes

  attr_reader :storage_model

  def initialize(opts = {})
    @model = opts[:model] || Storage::ConsecutivePrimesList
    @storage_model = opts[:storage_model] || MemoryStore
  end

  def run(count)
    @primes = @model.new(storage_model: storage_model)
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = storage_model.integer(count, id: :input_count)
    @biggest_test_generated = storage_model.integer(@primes.to_a.last, id: :biggest_test_generated)

    test = biggest_test_generated + 1

    make_new_test(test)

    @primes.to_a
  end

  def make_new_test(test)
    return if have_enough_results?
    raise "aborting loop: caller.size is #{caller.size}" if caller.size > 200

    test_result = is_prime?(test)
    store_result(test_result, test)

    self.biggest_test_generated = test

    if test_result
      make_more_tests_to(biggest_test_possible) unless have_enough_results?
    end
  end

  private

  def make_more_tests_to(test_limit)
    test_start = biggest_test_generated + 1

    if test_limit >= test_start
      (test_start..test_limit).each do |n|
        make_new_test(n)
      end
    end
  end

end
