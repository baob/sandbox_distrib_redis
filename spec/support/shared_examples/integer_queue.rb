shared_examples 'an integer queue' do

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

    describe '#to_a' do
      specify { expect(subject.to_a).to eql(initial_elements) }
    end

    describe '#min' do
      specify { expect(subject.min).to be(initial_elements.min) }
    end

    describe '#include' do
      specify { expect(subject.include?(initial_elements.first)).to be_truthy }
    end

    describe '#count' do
      specify { expect(subject.count).to eql(initial_elements.count) }
    end

    describe '#sort' do
      specify { expect(subject.sort).to eql(initial_elements.sort) }
    end

    describe '#delete' do
      specify 'deletes an element' do
        subject.delete(initial_elements.first)
        expect(subject.to_a).to eql(initial_elements[1..-1])
      end
    end

    describe '#min_pop' do
      specify { expect(subject.min_pop).to be(initial_elements.min) }

      specify 'deletes an element' do
        subject.min_pop
        expect(subject.to_a).to eql(initial_elements[1..-1])
      end
    end

    context 'and the initial elements are not in sequence' do
      let(:initial_elements) { [222, 33, 4] }

      describe '#to_a' do
        specify { expect(subject.to_a).to match_array(initial_elements) }
      end

      describe '#sort' do
        specify { expect(subject.sort).to eql(initial_elements.sort) }
      end
    end
  end

end
