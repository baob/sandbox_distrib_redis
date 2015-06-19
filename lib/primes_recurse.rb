require_relative 'storage/consecutive_primes_list'
require_relative 'storage/primes_list'
require_relative 'primes_seq'

class PrimesRecurse < PrimesSeq

  def initialize(opts = {})
    opts[:model] ||= Storage::ConsecutivePrimesList
    super
  end

  def run(count)
    @primes = @model.new
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = @model.integer(count, id: :input_count)
    @biggest_test_generated = @model.integer(@primes.to_a.last, id: :biggest_test_generated)

    test = biggest_test_generated + 1

    make_new_test(test)

    @primes.to_a
  end

  def make_new_test(test)
    return if have_enough_results?
    raise "aborting loop: caller.size is #{caller.size}" if caller.size > 200

    test_result = super
    self.biggest_test_generated = test

    if test_result
      make_more_tests_to(new_test_limit) unless have_enough_results?
    end
  end

  def new_test_limit
    (@primes.to_a.max + 1)**2 - 1
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

    if new_test_limit >= test_start
      (test_start..new_test_limit).each do |n|
        make_new_test(n)
      end
    end
  end

end
