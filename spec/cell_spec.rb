require './lib/cell'

describe Cell do
  subject { Cell.new('B4') }
  let(:ship) { Ship.new('Cruiser', 3) }

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
    it 'populates cell with ship' do
      expect(subject.place_ship(ship)).to eql(ship)
    end

    it 'makes cell no longer empty' do
      subject.place_ship(ship)
      should_not be_empty
    end
  end

  describe '#fire_upon' do
    it 'decreases ship health' do
      subject.place_ship(ship)
      subject.fire_upon
      expect(subject.ship.health).to eql(2)
    end

    it 'fires upon cell' do
      subject.place_ship(ship)
      subject.fire_upon
      expect(subject.fired_upon).to be true
    end
  end

  describe '#render' do
    it "returns '.' when not fired upon" do
      expect(subject.render).to eql('.')
    end

    it "returns 'M' when fired up and does not contain ship" do
      subject.fire_upon
      expect(subject.render).to eql('M')
    end

    it "returns 'H' when fired up and does not contain ship" do
      subject.place_ship(ship)
      subject.fire_upon
      expect(subject.render).to eql('H')
    end

    it "returns 'X' when fired and it's ship has sunk" do
      subject.place_ship(ship)
      3.times { subject.fire_upon }
      expect(subject.render).to eql('X')
    end

    it "returns 'S' when it is passed an optional boolean argument" do
      subject.place_ship(ship)
      expect(subject.render(true)).to eql('S')
    end
  end
end
