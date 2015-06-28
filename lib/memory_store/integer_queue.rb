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

    # NOTE: min_pop no longer implements min, it picks first
    def min_pop
      result = @array.first
      @array.delete(result)
      result
    end

    def count
      @array.count
    end

    def to_a
      @array
    end

    def empty?
      count == 0
    end

  end
end
