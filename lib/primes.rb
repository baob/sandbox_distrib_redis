require_relative 'primes_list'

class Primes

  INITIAL_PRIME_LIST = [2].freeze

  def initialize(opts)
    @input_count = opts.fetch(:count)
    @model = opts[:model] || PrimesList
    @primes = @model.new
  end

  def run
    INITIAL_PRIME_LIST.each { |n| @primes << n }

    test = @primes.to_a.last + 1
    while @primes.to_a.count < @input_count
      if is_prime?(test)
        @primes << test
      else
        @primes.add_non_prime(test)
      end
      test += 1
    end

    @primes.to_a
  end

  private

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
