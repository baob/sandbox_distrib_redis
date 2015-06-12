class Primes

  INITIAL_PRIME_LIST = [2].freeze

  def initialize(opts)
    @input_count = opts.fetch(:count)
  end

  def run
    @primes = INITIAL_PRIME_LIST.dup
    @primes << next_prime while @primes.count < @input_count
    @primes
  end

  private

  def next_prime
    test = @primes.last + 1

    while true
      break if is_prime?(test)
      test += 1
    end

    test
  end

  def is_prime?(test)
    limit = Math.sqrt(test.to_f).floor
    test_index = 0
    divisor_found = false

    while !divisor_found && test_index < @primes.count && @primes[test_index] <= limit
      break if divisor_found = test.remainder(@primes[test_index]) == 0
      test_index += 1
    end

    !divisor_found
  end

end
