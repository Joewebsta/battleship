require './lib/ship'

describe Ship do
  subject { Ship.new('Cruiser', 3) }

  describe '#initialize' do
    it 'has a name' do
      expect(subject.name).to eql('Cruiser')
    end

    it 'has a length' do
      expect(subject.length).to eql(3)
    end

    it 'has health equal to length' do
      expect(subject.health).to eql(subject.length)
    end

    it 'is not sunk by default' do
      should_not be_sunk
    end
  end

  describe '#hit' do
    it 'loses 1 health' do
      subject.hit
      expect(subject.health).to eql(2)
    end

    it 'sinks when hit enough times' do
      3.times { subject.hit }
      should be_sunk
    end
  end
end
