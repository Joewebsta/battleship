require './lib/board'

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

  describe '#validate_coordinate' do
    it 'validates the first coordinate on the board' do
      expect(subject.validate_coordinate('A1')).to be true
    end

    it 'validates the last coordinate on the board' do
      expect(subject.validate_coordinate('D4')).to be true
    end

    it 'validates a coordinate not on the board' do
      expect(subject.validate_coordinate('A5')).to be false
    end

    it 'validates another coordinate not on the board' do
      expect(subject.validate_coordinate('E1')).to be false
    end

    it 'validates yet another coordinate not on the board' do
      expect(subject.validate_coordinate('A22')).to be false
    end
  end
end
