require_relative 'primes'

class PrimesRecurse
  include Primes

  def initialize(opts = {})
    @list_model_name = opts[:list_model] || :consecutive_primes_list
    @storage_model_name = opts[:storage_model] || :memory_store
    @biggest_test_generated = storage_model.integer(INITIAL_PRIME_LIST.max, id: :biggest_test_generated)
  end

  def run(count)
    @primes = list_model
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = storage_model.integer(count, id: :input_count)

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
