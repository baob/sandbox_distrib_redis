require 'primes_redis_pop'
require 'memory_store'
require 'redis_store'

describe PrimesRedisPop do

  context 'with a redis storage model' do
    let(:storage_model) { :redis_store }
    subject { described_class.new(storage_model: storage_model) }

    it_behaves_like 'a primes finder'
  end

end
