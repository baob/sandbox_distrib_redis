shared_examples 'an integer queue' do

  context 'with elements' do
    before(:each) do
      initial_elements.each { |e| subject << e }
    end

    context 'when 3 elements are added in sequence' do
      let(:initial_elements) { [2, 3, 4] }

      describe '#min' do
        specify { expect(subject.min).to be(initial_elements.min) }
      end

      describe '#min_pop' do
        specify { expect(subject.min_pop).to be(initial_elements.min) }

        specify 'deletes an element' do
          subject.min_pop
          expect(subject.to_a).to eql(initial_elements[1..-1])
        end
      end
    end

    context 'and the initial elements are not in sequence' do
      let(:initial_elements) { [222, 33, 4] }

      describe '#to_a' do
        specify { expect(subject.to_a).to match_array(initial_elements) }
      end

      describe '#empty?' do
        specify { expect(subject.empty?).to be_falsey }
      end

      describe '#sort' do
        specify { expect(subject.sort).to eql(initial_elements.sort) }
      end

      describe '#min_pop' do
        specify { expect(subject.min_pop).to be(initial_elements.first) }

        specify 'deletes an element' do
          subject.min_pop
          expect(subject.to_a).to eql(initial_elements[1..-1])
        end
      end
    end

  end
end
