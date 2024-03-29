shared_examples 'a primes finder' do

  context 'initialised with count: 1' do
    specify { expect(subject.run(1)).to eql([2]) }
  end

  context 'initialised with count: 2' do
    specify { expect(subject.run(2)).to eql([2, 3]) }
  end

  context 'initialised with count: 3' do
    specify { expect(subject.run(3)).to eql([2, 3, 5]) }
  end

  context 'initialised with count: 5' do
    specify { expect(subject.run(5)).to eql([2, 3, 5, 7, 11]) }
  end

  context 'initialised with count: 10' do
    specify { expect(subject.run(10)).to eql([2, 3, 5, 7, 11, 13, 17, 19, 23, 29]) }
  end

  context 'initialised with count: 40' do
    specify 'completes in less than 2 seconds' do
      Timeout.timeout(2) do
        subject.run(40)
      end
    end
  end

end
