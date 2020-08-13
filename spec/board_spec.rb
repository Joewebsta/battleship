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

    it 'ensures last coordinate on the board is valid' do
      expect(subject.valid_coordinate?('D4')).to be true
    end

    it 'does not allow an invalid coordinate' do
      expect(subject.valid_coordinate?('A5')).to be false
    end

    it 'does not allow another invalid coordinate' do
      expect(subject.valid_coordinate?('E1')).to be false
    end

    it 'does not allow yet another invalid coordinate' do
      expect(subject.valid_coordinate?('A22')).to be false
    end
  end

  describe '#valid_placement?' do
    let(:cruiser) { Ship.new('Cruiser', 3) }
    let(:submarine) { Ship.new('Submarine', 2) }

    it 'does not allow coordinates shorter than ship length' do
      expect(subject.valid_placement?(cruiser, %w[A1 A2])).to be false
    end

    it 'does not allow coordinates longer than ship length' do
      expect(subject.valid_placement?(submarine, %w[A2 A3 A4])).to be false
    end

    it 'does not allow inconsecutive horizontal coordinates' do
      expect(subject.valid_placement?(cruiser, %w[A1 A2 A4])).to be false
    end

    it 'does not allow inconsecutive vertical coordinates' do
      expect(subject.valid_placement?(submarine, %w[A1 C1])).to be false
    end

    it 'does not allow backwards horiztontal coordinates' do
      expect(subject.valid_placement?(cruiser, %w[A3 A1 A1])).to be false
    end

    it 'does not allow backwards vertical coordinates' do
      expect(subject.valid_placement?(cruiser, %w[C1 B1])).to be false
    end

    it 'does not allow diagonal coordinates' do
      expect(subject.valid_placement?(cruiser, %w[A1 B2 C3])).to be false
    end

    it 'does not allow more diagonal coordinates' do
      expect(subject.valid_placement?(submarine, %w[C2 D3])).to be false
    end

    it 'allows a ship with valid coordinates' do
      expect(subject.valid_placement?(submarine, %w[A1 A2])).to be true
    end

    it 'allows another ship with valid coordinates' do
      expect(subject.valid_placement?(cruiser, %w[B1 C1 D1])).to be true
    end
  end
end
