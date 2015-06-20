require_relative 'primes'

class PrimesSeq
  include Primes

  def initialize(opts = {})
    @list_model_name = opts[:list_model] || :consecutive_primes_list
    @storage_model_name = opts[:storage_model] || :memory_store
  end

  def run(count)
    @primes = list_model
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
