shared_examples 'an integer store' do
  subject { described_class.new(value) }

  context 'when initialized with a value' do
    let(:value) { 578 }

    describe '#to_i' do
      specify { expect(subject.to_i).to eql(value) }
    end

    context 'and then set to another value' do
      let(:another_value) { 29 }

      describe '#to_i' do
        specify { subject.set(another_value) ; expect(subject.to_i).to eql(another_value) }
      end
    end
  end

  context 'with two store initalised with the same id params' do
    let(:a) { described_class.new(23) }
    let(:b) { described_class.new(97) }

    specify 'they use the same store' do
      new_value = 967
      expect { a.set(new_value).to change { b.to_i }.to(new_value) }
    end
  end

  context 'with two store initalised with different id params' do
    let(:a) { described_class.new(23, id: :a) }
    let(:b) { described_class.new(97, id: :b) }

    specify 'they use different stores' do
      new_value = 967
      expect { a.set(new_value).not_to change { b.to_i }.to(new_value) }
    end
  end

end
