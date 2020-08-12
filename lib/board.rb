require './lib/board_cells_generator'

class Board
  attr_reader :cells

  def initialize(rows)
    @cells = BoardCellsGenerator.new(rows).generate
  end

  def validate_coordinate(coordinate)
    cells.keys.include?(coordinate)
  end
end
