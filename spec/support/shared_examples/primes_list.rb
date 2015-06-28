shared_examples 'common primes list behaviour' do

  specify { expect(subject).to respond_to(:add_non_prime) }

  context 'when 3 elements are added in sequence' do
    let(:initial_elements) { [2, 3, 4] }
    before(:each) do
      initial_elements.each { |e| subject << e }
    end

    describe '#add_non_prime' do
      specify 'can be called with one argument' do
        subject.add_non_prime(double('something').as_null_object)
      end
    end

    describe '#last' do
      specify { expect(subject.last).to eql(initial_elements.last) }
    end

    describe '#[]' do
      specify { expect(subject[1]).to eql(initial_elements[1]) }
    end
  end

end

shared_examples 'a primes_list for non-consecutive elements' do

  context 'initialized with no arguments' do
    describe '#empty?' do
      specify { expect(subject.empty?).to be_truthy }
    end
  end

  context 'when 3 elements are added in sequence' do
    let(:initial_elements) { [2, 3, 4] }
    before(:each) do
      initial_elements.each { |e| subject << e }
    end

    describe '#empty?' do
      specify { expect(subject.empty?).to be_falsey }
    end

    describe '#include' do
      specify { expect(subject.include?(initial_elements.first)).to be_truthy }
    end

    describe '#sort' do
      specify { expect(subject.sort).to eql(initial_elements.sort) }
    end

    describe '#min' do
      specify { expect(subject.min).to be(initial_elements.min) }
    end

    describe '#delete' do
      specify 'deletes an element' do
        subject.delete(initial_elements.first)
        expect(subject.to_a).to eql(initial_elements[1..-1])
      end
    end
  end

end
