require_relative '../redis_store'
require_relative '../memory_store'

module Storage

  class ConsecutivePrimesList

    def initialize(value = nil, opts = {})
      @storage_model = opts[:storage_model] || MemoryStore
      @consecutive_primes_list = @storage_model.primes_list(value, id: :consecutive_primes_list)
      @non_consecutive_tests = @storage_model.primes_list(nil, id: :non_consecutive_tests)
      @non_consecutive_primes = @storage_model.primes_list(nil, id: :non_consecutive_primes)
      largest = @consecutive_primes_list.max || 1
      @largest_consecutive_test = @storage_model.integer(largest, id: :largest_consecutive_test)
    end

    def <<(n)
      add_new_prime(n)
      add_new_test(n)
    end

    def add_non_prime(n)
      add_new_test(n)
    end

    def to_a
      @consecutive_primes_list.to_a
    end

    def count
      @consecutive_primes_list.count
    end

    def last
      @consecutive_primes_list.last
    end

    def [](index)
      @consecutive_primes_list[index]
    end

    def include?(elem)
      @consecutive_primes_list.include?(elem)
    end

    def max
      @consecutive_primes_list.max
    end

    def all_results
      to_a + @non_consecutive_primes.sort
    end

    def largest_consecutive_test
      @largest_consecutive_test.to_i
    end

    def non_consecutive_tests
      @non_consecutive_tests.to_a
    end

    def non_consecutive_primes
      @non_consecutive_primes.to_a
    end

    private

    def largest_consecutive_test=(n)
      @largest_consecutive_test.set(n)
    end

    def next_consecutive?(n)
      n == largest_consecutive_test + 1
    end

    def add_new_test(n)
      if next_consecutive?(n)
        self.largest_consecutive_test = n
        update_consecutive_primes_list(n)
      else
        @non_consecutive_tests << n if n > largest_consecutive_test
      end
    end

    def add_new_prime(n)
      if next_consecutive?(n)
        @consecutive_primes_list << n
        update_consecutive_primes_list(n)
      else
        @non_consecutive_primes << n
      end
    end

    def update_consecutive_primes_list(n)
      test = n + 1

      while !@non_consecutive_tests.empty? && test == @non_consecutive_tests.min
        move_to_consecutive_tests(test)
        test += 1
      end
    end

    def move_to_consecutive_tests(n)
      self.largest_consecutive_test = n
      if @non_consecutive_primes.include?(n)
        @consecutive_primes_list << n
        @non_consecutive_primes.delete(n)
      end
      @non_consecutive_tests.delete(n)
    end

  end
end
