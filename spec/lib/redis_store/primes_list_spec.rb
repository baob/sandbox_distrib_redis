require_relative '../../../lib/redis_store/primes_list'

module RedisStore
  describe PrimesList do

    it_behaves_like 'an integer list'

    it_behaves_like 'common primes list behaviour'

  end
end
