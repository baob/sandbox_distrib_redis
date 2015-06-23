require 'primes_redis_pop'
require 'memory_store'
require 'redis_store'

describe PrimesRedisPop do

  context 'with PrimesList model' do
    let(:model) { :primes_list }
    let(:storage_model) { :memory_store }
    let(:queued_tests) { [2, 3, 4, 5] }
    subject { described_class.new(list_model: model, storage_model: storage_model) }

    describe '(collaboration with queued_test model)' do
      let(:queued_tests_model) { double('queued test model') }
      before(:each) do
        allow(MemoryStore).to receive(:integer_queue).with(anything, hash_including(id: :queued_tests)).and_return(queued_tests_model)
        allow(queued_tests_model).to receive(:<<).with(an_instance_of(Fixnum)).at_least(:once)
        allow(queued_tests_model).to receive(:count).and_return(1, 0)
        allow(queued_tests_model).to receive(:min_pop).and_return(3)
      end

      it 'queues tests with #<<' do
        expect(queued_tests_model).to receive(:<<).with(an_instance_of(Fixnum)).at_least(:once)
        subject.run(2)
      end

      it 'counts queued tests with #count' do
        expect(queued_tests_model).to receive(:count).and_return(1, 0)
        subject.run(2)
      end

      it 'pops queued tests with #min_pop' do
        expect(queued_tests_model).to receive(:min_pop).and_return(3)
        subject.run(2)
      end
    end

  end

end

