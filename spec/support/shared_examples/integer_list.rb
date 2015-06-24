shared_examples 'an integer list' do

  # Commonn functionality between primes result lists and lists of tests
  # (queue)

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

    describe '#count' do
      specify { expect(subject.count).to eql(initial_elements.count) }
    end

    describe '#include' do
      specify { expect(subject.include?(initial_elements.first)).to be_truthy }
    end

  end

end
