require_relative '../../../lib/redis_store/primes_list'

module RedisStore
  describe PrimesList do

    it_behaves_like 'an integer list'

    it_behaves_like 'common primes list behaviour'

    it_behaves_like 'a primes_list for non-consecutive elements'

  end
end
