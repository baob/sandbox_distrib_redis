require_relative '../../../lib/memory_store/primes_list'

module MemoryStore
  describe PrimesList do

    it_behaves_like 'an integer list'

    it_behaves_like 'common primes list behaviour'

  end
end
