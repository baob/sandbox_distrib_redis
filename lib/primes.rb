module Primes

  INITIAL_PRIME_LIST = [2].freeze

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

  def store_result(test_result, test)
    if test_result
      result_is_prime(test)
    else
      result_is_not_prime(test)
    end
  end

  def result_is_prime(test)
    if @primes.to_a.include?(test)
      raise "Primes#result_is_prime is adding #{test} again ... WHY ?"
    end
    @primes << test
  end

  def result_is_not_prime(test)
    @primes.add_non_prime(test)
  end

  private

  def biggest_test_possible
    (@primes.to_a.max + 1)**2 - 1
  end

  def biggest_test_generated=(n)
    @biggest_test_generated.set(n)
  end

  def biggest_test_generated
    @biggest_test_generated.to_i
  end

end
