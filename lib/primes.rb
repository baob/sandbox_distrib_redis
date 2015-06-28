require_relative 'storage/consecutive_primes_list'
require_relative 'memory_store'

module Primes

  INITIAL_PRIME_LIST = [2].freeze

  attr_reader :storage_model_name, :list_model_name, :prime_list

  def have_enough_results?
    prime_list.count >= @input_count.to_i
  end

  def is_prime?(candidate)
    if candidate > biggest_test_possible
      raise "candidate is #{candidate} but the biggest we can test is #{biggest_test_possible} because the max consecutive prime found is #{prime_list.max}"
    end
    test_index = 0
    divisor_found = false
    divisors_to_try = prime_list.to_a

    while !divisor_found && test_index < divisors_to_try.count
      test_value = divisors_to_try[test_index]
      break if test_value.nil?
      break if test_value * test_value > candidate
      break if divisor_found = candidate.remainder(test_value) == 0
      test_index += 1
    end

    unless divisor_found || (test_value + 1)**2 -1 > candidate
      raise "last test_value #{test_value} when squared did not reach limit #{candidate}"
    end

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
    if prime_list.include?(test)
      raise "Primes#result_is_prime is adding #{test} again ... WHY ?"
    end
    prime_list << test
  end

  def result_is_not_prime(test)
    prime_list.add_non_prime(test)
  end

  private

  def integer_queue(value = nil, opts ={})
    storage_model.integer_queue(value, opts)
  end

  def integer(value, opts ={})
    storage_model.integer(value, opts)
  end

  # 'Classify' the symbolic name of the class
  def storage_model
    @storage_model ||= Module.const_get(storage_model_name.to_s.split('_').map(&:capitalize).join)
  end

  def list_model(value = nil, opts = {})
    @list_model = storage_model.send(list_model_name, value, opts)
  end

  def biggest_test_possible
    (prime_list.max + 1)**2 - 1
  end

  def biggest_test_generated=(n)
    @biggest_test_generated.set(n)
  end

  def biggest_test_generated
    @biggest_test_generated.to_i
  end

end
