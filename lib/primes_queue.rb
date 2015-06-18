require_relative 'storage/consecutive_primes_list'
require_relative 'storage/primes_list'
require_relative 'primes'

class PrimesQueue < Primes

  def initialize(opts = {})
    opts[:model] ||= Storage::ConsecutivePrimesList
    super
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

    super
  end

  def queue_some_tests
    make_more_tests_to(new_test_limit) unless have_enough_results?
  end

  def new_test_limit
    (@primes.to_a.max + 1)**2 - 1
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

  def biggest_test_generated=(n)
    @biggest_test_generated.set(n)
  end

  def biggest_test_generated
    @biggest_test_generated.to_i
  end

  def make_more_tests_to(new_test_limit)
    test_start = biggest_test_generated + 1
    test_end = [biggest_test_generated + 10, new_test_limit].min

    if new_test_limit >= test_start
      (test_start..test_end).each do |n|
        queue_new_test(n)
      end
    end
  end

end
