module Storage
  class IntegerQueue

    def initialize(opts ={})
      @array = []
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
