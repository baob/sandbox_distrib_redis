require 'primes_list'

class ConsecutivePrimesList

  def initialize
    @consecutive_primes_list = PrimesList.new
    @non_consecutive_tests = Set.new
    @non_consecutive_primes = Set.new
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

  def all_results
    @consecutive_primes_list.to_a + @non_consecutive_primes.sort
  end

  def largest_consecutive_test
    @largest_consecutive_test
  end

  def non_consecutive_tests
    @non_consecutive_tests.to_a
  end

  def non_consecutive_primes
    @non_consecutive_primes.to_a
  end

  private

  def largest_consecutive_test=(n)
    @largest_consecutive_test = n
  end

  def next_consecutive?(n)
    largest_consecutive_test.nil? || n == largest_consecutive_test + 1
  end

  def add_new_test(n)
    if next_consecutive?(n)
      self.largest_consecutive_test = n
      update_consecutive_primes_list(n)
    else
      add_to_non_consecutive_tests(n)
    end
  end

  def add_new_prime(n)
    if next_consecutive?(n)
      @consecutive_primes_list << n
      update_consecutive_primes_list(n)
    else
      add_to_non_consecutive_primes(n)
    end
  end

  def remove_from_non_consecutive_tests(n)
    @non_consecutive_tests.delete(n)
  end

  def add_to_non_consecutive_tests(n)
    @non_consecutive_tests << n
  end

  def remove_from_non_consecutive_primes(n)
    @non_consecutive_primes.delete(n)
  end

  def add_to_non_consecutive_primes(n)
    @non_consecutive_primes << n
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
      remove_from_non_consecutive_primes(n)
    end
    remove_from_non_consecutive_tests(n)
  end

end