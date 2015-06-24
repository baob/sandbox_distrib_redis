require_relative '../../../lib/memory_store/integer_queue'

module MemoryStore
  describe IntegerQueue do

    it_behaves_like 'an integer list'

    it_behaves_like 'an integer queue'

  end
end
