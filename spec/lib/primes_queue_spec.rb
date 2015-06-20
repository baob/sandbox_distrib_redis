require 'primes_queue'
require 'storage/primes_list'
require 'redis_store'

describe PrimesQueue do

  it_behaves_like 'a primes finder'

  context 'with PrimesList model' do
    let(:model) { :primes_list }
    subject { described_class.new(list_model: model) }

    it_behaves_like 'a primes finder'
  end

  context 'with a redis storage model' do
    let(:storage_model) { RedisStore }
    subject { described_class.new(storage_model: storage_model) }

    it_behaves_like 'a primes finder'
  end

  describe '#queue_new_test' do
    context 'when queuing sequential tests' do
      let(:queued_tests) { [2, 3, 4, 5] }

      specify 'they get run in the same order' do
        queued_tests.each { |test| expect(subject).to receive(:make_new_test).with(test) }
        queued_tests.each { |test| subject.queue_new_test(test) }

        subject.run_queued_tests
      end

      specify 'does not run tests when run queued_tests is not called' do
        # this test will probably be superseded by next test
        # but it moves the code in the right direction
        queued_tests.each { |test| expect(subject).not_to receive(:make_new_test).with(test) }
        queued_tests.each { |test| subject.queue_new_test(test) }
      end
    end
  end

  describe '#run_queued_tests' do
    context 'when queuing non-sequential tests' do
      let(:queued_tests) { [2, 4, 3, 5] }

      specify 'they get run in ascending order' do
        queued_tests.sort.each { |test| expect(subject).to receive(:make_new_test).with(test).ordered }
        queued_tests.each { |test| subject.queue_new_test(test) }

        subject.run_queued_tests
      end
    end
  end

end
