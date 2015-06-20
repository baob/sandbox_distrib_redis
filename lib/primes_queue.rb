require_relative 'storage/consecutive_primes_list'
require_relative 'storage/primes_list'
require_relative 'primes'

class PrimesQueue
  include Primes

  attr_reader :storage_model

  def initialize(opts = {})
    @model = opts[:model] || Storage::ConsecutivePrimesList
    @storage_model = opts[:storage_model] || MemoryStore
    @queued_tests = storage_model.integer_queue(id: :queued_tests)
    @biggest_test_initial_value = storage_model.integer(INITIAL_PRIME_LIST.max, id: :biggest_test_generated)
    @biggest_test_generated = @biggest_test_initial_value
  end

  def run(count)
    @primes = @model.new(storage_model: storage_model)
    # @primes = @model.new
    @biggest_test_generated = @biggest_test_initial_value
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = storage_model.integer(count, id: :input_count)

    until have_enough_results?
      queue_some_tests
      run_queued_tests
    end

    @primes.to_a
  end

  def make_new_test(test)
    return if have_enough_results?
    test_result = is_prime?(test)
    store_result(test_result, test)
  end

  def queue_some_tests
    test_end = [biggest_test_generated + 10, biggest_test_possible].min
    queue_more_tests_to(test_end)
  end

  def queue_new_test(test)
    @queued_tests << test
    self.biggest_test_generated = test
  end

  def run_queued_tests
    while @queued_tests.count > 0
      test = @queued_tests.min
      make_new_test(test)
      @queued_tests.delete(test)
    end
  end

  private

  def queue_more_tests_to(test_limit)
    test_start = biggest_test_generated + 1

    if test_limit >= test_start
      (test_start..test_limit).each do |n|
        queue_new_test(n)
      end
    end
  end

end
