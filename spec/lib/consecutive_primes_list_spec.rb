require 'consecutive_primes_list'

describe ConsecutivePrimesList do
  subject do
    pl = described_class.new
    initial_list.each { |p| pl << p } unless initial_list.empty?
    pl
  end

  context 'initialised with 2, 3' do
    let(:initial_list) { [2, 3] }

    describe '#to_a' do
      specify { expect(subject.to_a).to eql(initial_list) }
    end

    describe '#all_results' do
      specify { expect(subject.all_results).to eql(initial_list) }
    end

    context 'and 5 is added as a prime' do
      let(:added_primes) { [5] }
      before { added_primes.each { |p| subject << p } }

      describe '#to_a' do
        specify { expect(subject.to_a).to eql(initial_list) }
      end

      describe '#all_results' do
        specify { expect(subject.all_results).to eql(initial_list + added_primes) }
      end

      describe '#largest_consecutive_test' do
        specify { expect(subject.largest_consecutive_test).to eql(initial_list.last) }
      end

      describe '#non_consecutive_tests' do
        specify { expect(subject.non_consecutive_tests).to eql(added_primes) }
      end

      describe '#non_consecutive_primes' do
        specify { expect(subject.non_consecutive_primes).to eql(added_primes) }
      end
    end

  end
end
