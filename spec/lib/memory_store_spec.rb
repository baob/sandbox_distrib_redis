require_relative '../../lib/memory_store'
require_relative '../../lib/storage/consecutive_primes_list'

describe MemoryStore do
  let(:number) { double('number') }
  let(:array) { double('array') }
  let(:opts) { double('opts') }
  let(:model) { double('model') }

  describe '.integer' do
    specify 'instantiates IntegerStore passing same params, and returns instance' do
      expect(MemoryStore::IntegerStore).to receive(:new).with(number, opts).and_return(model)
      expect(described_class.integer(number, opts)).to eql(model)
    end
  end

  describe '.integer_queue' do
    specify 'instantiates IntegerQueue passing same params, and returns instance' do
      expect(MemoryStore::IntegerQueue).to receive(:new).with(array, opts).and_return(model)
      expect(described_class.integer_queue(array, opts)).to eql(model)
    end
  end

  describe '.primes_list' do
    specify 'instantiates PrimesList passing same params, and returns instance' do
      expect(MemoryStore::PrimesList).to receive(:new).with(array, opts).and_return(model)
      expect(described_class.primes_list(array, opts)).to eql(model)
    end
  end

  describe '.consecutive_primes_list' do
    let(:opts) { double('opts').as_null_object }
    let(:merged_opts) { double('opts') }

    specify 'instantiates ConsecutivePrimesList passing array param, and returns instance' do
      expect(Storage::ConsecutivePrimesList).to receive(:new).with(array, anything).and_return(model)
      expect(described_class.consecutive_primes_list(array, opts)).to eql(model)
    end

    specify 'opts passed to ConsecutivePrimesList after merging MemoryStore' do
      expect(opts).to receive(:merge).with(storage_model: MemoryStore).and_return(merged_opts)
      expect(Storage::ConsecutivePrimesList).to receive(:new).with(anything, merged_opts)
      described_class.consecutive_primes_list(array, opts)
    end
  end

end
