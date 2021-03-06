require './lib/board'
require './lib/ship'
require './lib/cell'

describe Board do
  subject { Board.new(4) }
  let(:cruiser) { Ship.new('Cruiser', 3) }
  let(:submarine) { Ship.new('Submarine', 2) }

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

    it 'does not allow overlapping ships' do
      subject.place(cruiser, %w[A1 A2 A3])
      expect(subject.valid_placement?(submarine, %w[A1 A2])).to be false
    end
  end

  describe '#place' do
    it 'places the same ship object in multiple cells' do
      subject.place(cruiser, %w[A1 A2 A3])
      expect(subject.cells['A1'].ship.object_id).to eql(cruiser.object_id)
      expect(subject.cells['A2'].ship.object_id).to eql(cruiser.object_id)
      expect(subject.cells['A3'].ship.object_id).to eql(cruiser.object_id)
    end

    it 'confirms the first and last cells hold the same ship' do
      subject.place(cruiser, %w[A1 A2 A3])
      expect(subject.cells['A1'].ship.object_id).to eql(subject.cells['A3'].ship.object_id)
    end
  end

  describe '#render' do
    it 'renders a starting board' do
      rendered_board =
        "  1 2 3 4 \n" \
        "A . . . . \n" \
        "B . . . . \n" \
        "C . . . . \n" \
        "D . . . . \n"
      expect(subject.render).to eql(rendered_board)
    end

    it 'renders a starting board and reveals the placement of ships' do
      subject.place(cruiser, %w[A1 A2 A3])
      subject.place(submarine, %w[C2 D2])

      rendered_board =
        "  1 2 3 4 \n" \
        "A S S S . \n" \
        "B . . . . \n" \
        "C . S . . \n" \
        "D . S . . \n"
      expect(subject.render(true)).to eql(rendered_board)
    end

    it 'renders misses' do
      subject.place(cruiser, %w[A1 A2 A3])
      subject.place(submarine, %w[C2 D2])
      subject.cells['B3'].fire_upon
      subject.cells['C4'].fire_upon

      rendered_board =
        "  1 2 3 4 \n" \
        "A S S S . \n" \
        "B . . M . \n" \
        "C . S . M \n" \
        "D . S . . \n"
      expect(subject.render(true)).to eql(rendered_board)
    end

    it 'renders hits' do
      subject.place(cruiser, %w[A1 A2 A3])
      subject.place(submarine, %w[C2 D2])
      subject.cells['A2'].fire_upon
      subject.cells['C2'].fire_upon

      rendered_board =
        "  1 2 3 4 \n" \
        "A S H S . \n" \
        "B . . . . \n" \
        "C . H . . \n" \
        "D . S . . \n"
      expect(subject.render(true)).to eql(rendered_board)
    end

    it 'renders sunken ships' do
      subject.place(cruiser, %w[A1 A2 A3])
      subject.place(submarine, %w[C2 D2])
      subject.cells['A1'].fire_upon
      subject.cells['A2'].fire_upon
      subject.cells['A3'].fire_upon
      subject.cells['C2'].fire_upon
      subject.cells['D2'].fire_upon

      rendered_board =
        "  1 2 3 4 \n" \
        "A X X X . \n" \
        "B . . . . \n" \
        "C . X . . \n" \
        "D . X . . \n"
      expect(subject.render(true)).to eql(rendered_board)
    end

    it 'renders hits, misses and sunken ships simultaneously' do
      subject.place(cruiser, %w[A1 A2 A3])
      subject.place(submarine, %w[C2 D2])
      subject.cells['A1'].fire_upon
      subject.cells['B2'].fire_upon
      subject.cells['C2'].fire_upon
      subject.cells['D2'].fire_upon
      subject.cells['D4'].fire_upon

      rendered_board =
        "  1 2 3 4 \n" \
        "A H S S . \n" \
        "B . M . . \n" \
        "C . X . . \n" \
        "D . X . M \n"
      expect(subject.render(true)).to eql(rendered_board)
    end
  end
end
