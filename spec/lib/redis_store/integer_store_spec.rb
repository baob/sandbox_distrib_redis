require_relative '../../../lib/redis_store/integer_store'

module RedisStore
  describe IntegerStore do

    it_behaves_like 'an integer store'

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
end
