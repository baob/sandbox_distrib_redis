module Storage
  class PrimesList # < Array

    def initialize(opts = {})
      @array = []
    end

    def to_a
      @array
    end

    def add_non_prime(n)
      nil
    end

    def <<(elem)
      @array << elem
    end

    def self.integer(*args)
      IntegerStore.new(*args)
    end

  end
end
