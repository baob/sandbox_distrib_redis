require_relative 'storage/primes_list'
require_relative 'primes'

class PrimesSeq
  include Primes

  def initialize(opts = {})
    @model = opts[:model] || Storage::PrimesList
  end

  def run(count)
    @primes = @model.new
    INITIAL_PRIME_LIST.each { |n| @primes << n }
    @input_count = @model.integer(count, id: :input_count)

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

    test_result
  end

end
