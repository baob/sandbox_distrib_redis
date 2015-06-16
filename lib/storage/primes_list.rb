module Storage
  class PrimesList < Array

    def add_non_prime(n)
      nil
    end

    def self.integer(*args)
      IntegerStore.new(*args)
    end

  end
end
