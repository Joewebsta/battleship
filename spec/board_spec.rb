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
end
