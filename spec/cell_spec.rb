require './lib/cell'

describe Cell do
  subject { Cell.new('B4') }

  describe '#initialize' do
    it 'has a coordinate' do
      expect(subject.coordinate).to eql('B4')
    end

    it 'does not have ship placed within it by default' do
      expect(subject.ship).to be_nil
    end

    it 'is empty by default' do
      should be_empty
    end
  end

  describe '#place_ship' do
    let(:ship) { Ship.new('Cruiser', 3) }

    it 'populates cell with ship' do
      expect(subject.place_ship(ship)).to eql(ship)
    end

    it 'makes cell no longer empty' do
      subject.place_ship(ship)
      should_not be_empty
    end
  end
end
