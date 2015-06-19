shared_examples 'an integer store' do
  subject { described_class.new(value) }

  context 'when initialized with a value' do
    let(:value) { double('the value') }

    describe '#to_i' do
      specify { expect(subject.to_i).to eql(value) }
    end

    context 'and then set to another value' do
      let(:another_value) { double('another value') }

      describe '#to_i' do
        specify { subject.set(another_value) ; expect(subject.to_i).to eql(another_value) }
      end
    end
  end

end