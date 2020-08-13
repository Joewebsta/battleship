require './lib/board'
require './lib/ship'

describe Board do
  subject { board = Board.new(4) }

  describe '#initialize' do
    it 'creates a cells hash' do
      expect(subject.cells).to be_a Hash
    end

    it 'creates a cells hash with 16 keys' do
      expect(subject.cells.keys.length).to eql(16)
    end

    it 'creates a cells hash with keys that point to cell objects' do
      subject.cells.each do |key, _val|
        expect(subject.cells[key]).to be_an_instance_of(Cell)
      end
    end
  end

  describe '#valid_coordinate?' do
    it 'ensures first coordinate on the board is valid' do
      expect(subject.valid_coordinate?('A1')).to be true
    end

    it 'ensures the last coordinate on the board is valid' do
      expect(subject.valid_coordinate?('D4')).to be true
    end

    it 'does not allow a coordinate not on the board' do
      expect(subject.valid_coordinate?('A5')).to be false
    end

    it 'does not allow another coordinate not on the board' do
      expect(subject.valid_coordinate?('E1')).to be false
    end

    it 'does not allow yet another coordinate not on the board' do
      expect(subject.valid_coordinate?('A22')).to be false
    end
  end

  describe '#valid_placement?' do
    let(:cruiser) { Ship.new('Cruiser', 3) }
    let(:submarine) { Ship.new('Submarine', 2) }

    it 'does not validate coordinates that do not equal ship length' do
      expect(subject.valid_placement?(cruiser, %w[A1 A2])).to be false
    end

    it 'does not validate different coordinates that do not equal ship length' do
      expect(subject.valid_placement?(submarine, %w[A2 A3 A4])).to be false
    end

    it 'does not validate inconsecutive coordinates' do
      expect(subject.valid_placement?(cruiser, %w[A1 A2 A4])).to be false
    end
  end
end
