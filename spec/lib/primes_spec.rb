require 'primes'
require 'storage/consecutive_primes_list'

describe Primes do

  it_behaves_like 'a primes finder'

  context 'with ConsecutivePrimesList model' do
    let(:model) { Storage::ConsecutivePrimesList }
    subject { described_class.new(model: model) }

    it_behaves_like 'a primes finder'
  end

end
