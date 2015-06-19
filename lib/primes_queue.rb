require_relative 'storage/consecutive_primes_list'
require_relative 'storage/primes_list'
require_relative 'primes'

class PrimesQueue
  include Primes

  def initialize(opts = {})
    @model = opts[:model] || Storage::ConsecutivePrimesList
    @queued_tests = Storage::VolatilePrimesList.new
    @biggest_test_initial_value = @model.integer(INITIAL_PRIME_LIST.max, id: :biggest_test_generated)
    @biggest_test_generated = @biggest_test_initial_value
  end

  def run(count)
    @primes = @model.new
    @biggest_test_generated = @biggest_test_initial_value
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = @model.integer(count, id: :input_count)

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
    make_more_tests_to(biggest_test_possible) unless have_enough_results?
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

  def make_more_tests_to(test_limit)
    test_start = biggest_test_generated + 1
    test_end = [biggest_test_generated + 10, test_limit].min

    if test_limit >= test_start
      (test_start..test_end).each do |n|
        queue_new_test(n)
      end
    end
  end

end
