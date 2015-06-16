require_relative 'storage/consecutive_primes_list'
require_relative 'storage/primes_list'
require_relative 'primes'

class PrimesRecurse < Primes

  def initialize(opts = {})
    opts[:model] ||= Storage::ConsecutivePrimesList
    super
  end

  def run(count)
    @primes = @model.new
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = @model.integer(count, id: :input_count)
    @biggest_test_generated = @model.integer(@primes.to_a.last, id: :biggest_test_generated)

    test = @biggest_test_generated.to_i + 1

    make_new_test(test)

    @primes.to_a
  end

  def make_new_test(test)
    return if have_enough_results?
    raise "aborting loop: caller.size is #{caller.size}" if caller.size > 200

    test_result = super
    @biggest_test_generated.set(test)

    if test_result
      new_test_limit = test**2 - 1
      make_more_tests_to(new_test_limit) unless have_enough_results?
    end
  end

  private

  def make_more_tests_to(new_test_limit)
    test_start = @biggest_test_generated.to_i + 1

    if new_test_limit >= test_start
      (test_start..new_test_limit).each do |n|
        make_new_test(n)
      end
    end
  end

end
