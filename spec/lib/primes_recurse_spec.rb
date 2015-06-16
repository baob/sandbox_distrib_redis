require 'primes_recurse'
require 'storage/primes_list'

describe PrimesRecurse do

  it_behaves_like 'a primes finder'

  context 'with PrimesList model' do
    let(:model) { Storage::PrimesList }
    subject { described_class.new(model: model) }

    it_behaves_like 'a primes finder'
  end

end
