module Storage
  class VolatileInteger

    def initialize(n, opts = {})
      @value = n
    end

    def to_i
      @value
    end

    def set(n)
      @value = n
    end

  end
end
