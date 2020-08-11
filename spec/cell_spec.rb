require './lib/cell'

describe Cell do
  subject { Cell.new('B4') }

  describe '#initialize' do
    it 'has a coordinate' do
      expect(subject.coordinate).to eql('B4')
    end

    # it 'does not contain part of a ship' do
    #   expect(subject.ship).to be_nil
    # end

    it 'is empty' do
      should be_empty
    end

    it 'is not hit' do
      should_not be_fired_upon
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

  describe '#fire_upon' do
    let(:ship) { Ship.new('Cruiser', 3) }

    it 'decreases ship health' do
      subject.place_ship(ship)
      subject.fire_upon
      expect(subject.ship.health).to eql(2)
    end

    it 'fires upon cell' do
      subject.place_ship(ship)
      subject.fire_upon
      expect(subject.fired_upon).to be_true
    end
  end
end
