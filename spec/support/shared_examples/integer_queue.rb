shared_examples 'an integer queue' do

  context 'when 3 elements are added in sequence' do
    let(:initial_elements) { [2, 3, 4] }
    before(:each) do
      initial_elements.each { |e| subject << e }
    end

    describe '#to_a' do
      specify { expect(subject.to_a).to eql(initial_elements) }
    end
  end

end
