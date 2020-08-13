require './lib/board_cells_generator'

class Board
  attr_reader :cells

  def initialize(rows)
    @cells = BoardCellsGenerator.new(rows).generate
  end

  def validate_coordinate(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.length

    row_num = Math.sqrt(cells.length).to_i
    valid_consec_positions = []

    row_letter = 'A'
    1.upto(row_num) do
      rows = cells.keys.select { |cell| cell.include?(row_letter) }
      rows.each_cons(3) { |consec_cells| valid_consec_positions << consec_cells }
      row_letter.next!
    end

    1.upto(row_num) do |i|
      columns = cells.keys.select { |cell| cell.include?(i.to_s) }
      columns.each_cons(3) { |consec_cells| valid_consec_positions << consec_cells }
    end

    valid_consec_positions.any? { |consec_positions| consec_positions == coordinates }
  end
end
