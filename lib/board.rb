require './lib/board_cells_generator'

class Board
  attr_reader :cells

  def initialize(rows)
    @cells = BoardCellsGenerator.new(rows).generate
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    ship_length = ship.length
    return false if ship_length != coordinates.length

    tot_rows = Math.sqrt(cells.length).to_i

    valid_consec_positions = consec_rows(tot_rows, ship_length) + consec_cols(tot_rows, ship_length)
    valid_consec_positions.one? { |position| position == coordinates }
  end

  def consec_cols(tot_rows, ship_length)
    consec_positions = []
    1.upto(tot_rows) do |i|
      columns = cells.keys.select { |cell| cell.include?(i.to_s) }
      columns.each_cons(ship_length) { |consec_cells| consec_positions << consec_cells }
    end

    consec_positions
  end

  def consec_rows(tot_rows, ship_length)
    row_letter = 'A'
    consec_positions = []
    1.upto(tot_rows) do
      rows = cells.keys.select { |cell| cell.include?(row_letter) }
      rows.each_cons(ship_length) { |consec_cells| consec_positions << consec_cells }
      row_letter.next!
    end

    consec_positions
  end
end
