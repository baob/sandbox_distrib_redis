require 'primes_list'

class ConsecutivePrimesList

  def initialize
    @primes_list = PrimesList.new
    @consecutive_primes_list = PrimesList.new
    @non_consecutive_tests = Set.new
    @non_consecutive_primes = Set.new
  end

  def <<(n)
    add_new_prime(n)
    add_new_test(n)
    update_consecutive_primes_list
  end

  def to_a
    @consecutive_primes_list.to_a
  end

  def all_results
    @primes_list.to_a
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

  def add_new_test(n)
    if largest_consecutive_test.nil?
      self.largest_consecutive_test = n
      remove_from_non_consecutive_tests(n)
    elsif n == largest_consecutive_test + 1
      self.largest_consecutive_test = n
      remove_from_non_consecutive_tests(n)
    else
      add_to_non_consecutive_tests(n)
    end
  end

  def add_new_prime(n)
    @primes_list << n
    if largest_consecutive_test.nil?
      remove_from_non_consecutive_primes(n)
    elsif n == largest_consecutive_test + 1
      remove_from_non_consecutive_primes(n)
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

  def update_consecutive_primes_list
    @primes_list.to_a.select{ |n| n > ( @consecutive_primes_list.max || 0 ) && n <= largest_consecutive_test }.each { |n| @consecutive_primes_list << n }
  end

end
