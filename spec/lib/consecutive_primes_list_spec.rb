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

    context 'and 4 is added as a non-prime' do
      let(:added_non_primes) { [4] }
      before { added_non_primes.each { |np| subject.add_non_prime(np) } }

      describe '#to_a' do
        specify { expect(subject.to_a).to eql(initial_list) }
      end

      describe '#all_results' do
        specify { expect(subject.all_results).to eql(initial_list) }
      end

      describe '#largest_consecutive_test' do
        specify { expect(subject.largest_consecutive_test).to eql(added_non_primes.last) }
      end

      describe '#non_consecutive_tests' do
        specify { expect(subject.non_consecutive_tests).to be_empty }
      end

      describe '#non_consecutive_primes' do
        specify { expect(subject.non_consecutive_primes).to be_empty }
      end

      context 'and then 5 is added as a prime' do
        let(:added_primes) { [5] }
        before { added_primes.each { |p| subject << p } }

        describe '#to_a' do
          specify { expect(subject.to_a).to eql(initial_list + added_primes) }
        end

        describe '#all_results' do
          specify { expect(subject.all_results).to eql(initial_list + added_primes) }
        end

        describe '#largest_consecutive_test' do
          specify { expect(subject.largest_consecutive_test).to eql(added_primes.last) }
        end

        describe '#non_consecutive_tests' do
          specify { expect(subject.non_consecutive_tests).to be_empty }
        end

        describe '#non_consecutive_primes' do
          specify { expect(subject.non_consecutive_primes).to be_empty }
        end
      end
    end

    context 'and 7, 5 are added as a prime out-of-sequence' do
      let(:added_primes) { [7, 5] }
      before { added_primes.each { |p| subject << p } }

      describe '#to_a' do
        specify { expect(subject.to_a).to eql(initial_list) }
      end

      describe '#all_results' do
        specify { expect(subject.all_results).to eql(initial_list + added_primes.sort) }
      end

      describe '#largest_consecutive_test' do
        specify { expect(subject.largest_consecutive_test).to eql(initial_list.last) }
      end

      describe '#non_consecutive_tests' do
        specify { expect(subject.non_consecutive_tests).to match_array(added_primes) }
      end

      describe '#non_consecutive_primes' do
        specify { expect(subject.non_consecutive_primes).to match_array(added_primes) }
      end

      context 'and then 6 and 4 are added as a non-prime out-of-sequence' do
        let(:added_non_primes) { [6, 4] }
        before { added_non_primes.each { |np| subject.add_non_prime(np) } }

        describe '#to_a' do
          specify { expect(subject.to_a).to eql(initial_list + added_primes.sort) }
        end

        describe '#all_results' do
          specify { expect(subject.all_results).to eql(initial_list + added_primes.sort) }
        end

        describe '#largest_consecutive_test' do
          specify { expect(subject.largest_consecutive_test).to eql(added_primes.max) }
        end

        describe '#non_consecutive_tests' do
          specify { expect(subject.non_consecutive_tests).to be_empty }
        end

        describe '#non_consecutive_primes' do
          specify { expect(subject.non_consecutive_primes).to be_empty }
        end
      end
    end


    context 'and 6 and 4 are added as a non-prime out-of-sequence' do
      let(:added_non_primes) { [6, 4] }
      before { added_non_primes.each { |np| subject.add_non_prime(np) } }

      describe '#to_a' do
        specify { expect(subject.to_a).to eql(initial_list) }
      end

      describe '#all_results' do
        specify { expect(subject.all_results).to eql(initial_list) }
      end

      describe '#largest_consecutive_test' do
        specify { expect(subject.largest_consecutive_test).to eql(4) }
      end

      describe '#non_consecutive_tests' do
        specify { expect(subject.non_consecutive_tests).to match_array([6]) }
      end

      describe '#non_consecutive_primes' do
        specify { expect(subject.non_consecutive_primes).to be_empty }
      end

      context 'and then 7, 5 are added as a prime out-of-sequence' do
        let(:added_primes) { [7, 5] }
        before { added_primes.each { |p| subject << p } }

        describe '#to_a' do
          specify { expect(subject.to_a).to eql(initial_list + added_primes.sort) }
        end

        describe '#all_results' do
          specify { expect(subject.all_results).to eql(initial_list + added_primes.sort) }
        end

        describe '#largest_consecutive_test' do
          specify { expect(subject.largest_consecutive_test).to eql(added_primes.max) }
        end

        describe '#non_consecutive_tests' do
          specify { expect(subject.non_consecutive_tests).to be_empty }
        end

        describe '#non_consecutive_primes' do
          specify { expect(subject.non_consecutive_primes).to be_empty }
        end
      end
    end

  end
end
