shared_examples 'common primes list behaviour' do

  specify { expect(subject).to respond_to(:add_non_prime) }

  context 'when initialised with 3 elements' do
    let(:initial_elements) { [2, 3, 4] }

    subject { described_class.new(initial_elements) }

    describe '#to_a' do
      specify { expect(subject.to_a).to eql(initial_elements) }
    end
  end

  context 'when 3 elements are added in sequence' do
    let(:initial_elements) { [2, 3, 4] }
    before(:each) do
      initial_elements.each { |e| subject << e }
    end

    describe '#to_a' do
      specify { expect(subject.to_a).to eql(initial_elements) }
    end

    describe '#add_non_prime' do
      specify 'can be called with one argument' do
        subject.add_non_prime(double('something').as_null_object)
      end
    end

    describe '#count' do
      specify { expect(subject.count).to eql(initial_elements.count) }
    end

    describe '#last' do
      specify { expect(subject.last).to eql(initial_elements.last) }
    end

    describe '#[]' do
      specify { expect(subject[1]).to eql(initial_elements[1]) }
    end
  end

end
