class Primes

  INITIAL_PRIME_LIST = [2].freeze

  def initialize(opts)
    @input_count = opts.fetch(:count)
    @primes = []
  end

  def run
    INITIAL_PRIME_LIST.each { |n| @primes << n }

    test = @primes.last + 1
    while @primes.count < @input_count
      @primes << test if is_prime?(test)
      test += 1
    end

    @primes.to_a
  end

  private

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
