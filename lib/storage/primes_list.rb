module Storage
  class PrimesList < Array

    def add_non_prime(n)
      nil
    end

    def self.integer(*args)
      VolatileInteger.new(*args)
    end

  end
end
