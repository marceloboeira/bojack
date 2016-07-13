module BoJack
  class Memory(K, V)
    struct Entry(V)
      getter value
      def initialize(@value : V); end
    end

    def initialize
      @cache = {} of K => Entry(V)
    end

    def write(key : K, value : V) : V
      @cache[key] = Entry.new(value)

      value
    end

    def read(key : K) : V?
      if entry = @cache[key]?
        entry.value
      else 
        raise "#{key.to_s} is not a valid key"
      end
    end

    def delete(key : K) : V?
      if entry = @cache.delete(key)
        entry.value
      else 
        raise "#{key.to_s} is not a valid key"
      end
    end

    def size
      @cache.size
    end

    private def read_entry(key : K) : Entry(V)?
      if entry = @cache[key]?
        entry
      end
    end
  end
end
