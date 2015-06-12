require 'primes'

describe Primes do
  context 'initialised with count: 1' do
    subject { described_class.new(count: 1) }

    specify { expect(subject.run).to eql([2]) }
  end

  context 'initialised with count: 2' do
    subject { described_class.new(count: 2) }

    specify { expect(subject.run).to eql([2, 3]) }
  end

  context 'initialised with count: 3' do
    subject { described_class.new(count: 3) }

    specify { expect(subject.run).to eql([2, 3, 5]) }
  end

  context 'initialised with count: 5' do
    subject { described_class.new(count: 5) }

    specify { expect(subject.run).to eql([2, 3, 5, 7, 11]) }
  end
end
