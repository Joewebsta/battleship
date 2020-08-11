require './lib/ship'

describe Ship do
  before { @ship = Ship.new('Cruiser', 3) }

  describe '#initialize' do
    it 'has a name' do
      expect(@ship.name).to eql('Cruiser')
    end

    it 'has a length' do
      expect(@ship.length).to eql(3)
    end

    it 'has health equal to length' do
      expect(@ship.health).to eql(@ship.length)
    end

    it 'is not sunk by default' do
      expect(@ship.sunk?).to be false
    end
  end

  describe '#hit' do
    it 'loses 1 health' do
      @ship.hit
      expect(@ship.health).to eql(2)
    end
  end
end
