require 'primes_recurse'

describe PrimesRecurse do

  it_behaves_like 'a primes finder'

  context 'with PrimesList model' do
    let(:model) { :primes_list }
    subject { described_class.new(list_model: model) }

    it_behaves_like 'a primes finder'
  end

end
