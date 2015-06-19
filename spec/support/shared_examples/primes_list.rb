shared_examples 'common primes list behaviour' do

  specify { expect(subject).to respond_to(:add_non_prime) }

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
  end

end
