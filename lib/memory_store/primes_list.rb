module MemoryStore
  class PrimesList

    def initialize(value = nil, opts = {})
      @array = value.nil? ? [] : value
    end

    def to_a
      @array
    end

    def sort(*args)
      @array.sort(*args)
    end

    def min
      sort.first
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

    def empty?
      count == 0
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

    def delete(n)
      @array.delete(n)
    end

  end
end
