module MemoryStore
  class PrimesList

    def initialize(value = nil, opts = {})
      @array = value.nil? ? [] : value
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

    def count
      @array.count
    end

    def last
      @array.last
    end

    def [](index)
      @array[index]
    end

    def include?(elem)
      @array.include?(elem)
    end

    def max
      @array.max
    end

  end
end
