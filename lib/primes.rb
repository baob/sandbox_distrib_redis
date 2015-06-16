require_relative 'storage/primes_list'

class Primes

  INITIAL_PRIME_LIST = [2].freeze

  def initialize(opts = {})
    @model = opts[:model] || Storage::PrimesList
    @primes = @model.new
  end

  def run(count)
    @input_count = count
    INITIAL_PRIME_LIST.each { |n| @primes << n }

    test = @primes.to_a.last + 1
    until have_enough_results?
      make_new_test(test)
      test += 1
    end

    @primes.to_a
  end

  def make_new_test(test)
    return if have_enough_results?
    raise "aborting loop: caller.size is #{caller.size}" if caller.size > 200

    test_result = is_prime?(test)
    store_result(test_result, test)
  end

  def store_result(test_result, test)
    if test_result
      result_is_prime(test)
    else
      result_is_not_prime(test)
    end
  end

  def result_is_prime(test)
    @primes << test
  end

  def result_is_not_prime(test)
    @primes.add_non_prime(test)
  end

  private

  def have_enough_results?
    @primes.to_a.count >= @input_count.to_i
  end

  def is_prime?(candidate)
    test_index = 0
    test_value = nil
    divisor_found = false

    while !divisor_found && test_index < @primes.to_a.count
      test_value = @primes.to_a[test_index]
      break if test_value.nil?
      break if test_value * test_value > candidate
      break if divisor_found = candidate.remainder(test_value) == 0
      test_index += 1
    end

    raise "last test_value #{test_value} when squared did not reach limit #{candidate}" unless divisor_found || test_value * test_value > candidate

    !divisor_found
  end

end
