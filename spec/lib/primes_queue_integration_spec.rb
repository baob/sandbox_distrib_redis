require 'primes_queue'
require 'memory_store'
require 'redis_store'

describe PrimesQueue do

  it_behaves_like 'a primes finder'

  context 'with PrimesList model' do
    let(:model) { :primes_list }
    subject { described_class.new(list_model: model) }

    it_behaves_like 'a primes finder'
  end

  context 'with a redis storage model' do
    let(:storage_model) { :redis_store }
    subject { described_class.new(storage_model: storage_model) }

    it_behaves_like 'a primes finder'
  end

end
