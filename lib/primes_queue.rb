require_relative 'primes'

class PrimesQueue
  include Primes

  def initialize(opts = {})
    @list_model_name = opts[:list_model] || :consecutive_primes_list
    @storage_model_name = opts[:storage_model] || :memory_store
    @biggest_test_generated = integer(INITIAL_PRIME_LIST.max, id: :biggest_test_generated)
    @queued_tests = integer_queue(nil, id: :queued_tests)
  end

  def run(count)
    @prime_list = list_model(INITIAL_PRIME_LIST.dup, id: :prime_list)
    @input_count = integer(count, id: :input_count)

    until have_enough_results?
      queue_some_tests
      run_queued_tests
    end

    prime_list.to_a
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
