module MemoryStore
  class IntegerQueue

    def initialize(value = nil, opts ={})
      @array = value.nil? ? [] : value
    end

    def <<(elem)
      @array << elem
    end

    def sort
      @array.sort
    end

    def min
      @array.min
    end

    def min_pop
      result = min
      delete(result)
      result
    end

    def count
      @array.count
    end

    def to_a
      @array
    end

    def delete(elem)
      @array.delete(elem)
    end

    def empty?
      count == 0
    end

    def include?(elem)
      @array.include?(elem)
    end

  end
end
