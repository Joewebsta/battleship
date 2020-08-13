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
    tot_rows = Math.sqrt(cells.length).to_i

    return false if ship_length != coordinates.length

    valid_consec_positions = consec_rows(tot_rows, ship_length) + consec_cols(tot_rows, ship_length)
    valid_consec_positions.one? { |position| position == coordinates }
  end

  def consec_cols(tot_rows, ship_length)
    consec_positions = 1.upto(tot_rows).map do |i|
      column_arrays = create_arr_of_column(i)
      create_consec_cell_arrs(column_arrays, ship_length)
    end

    consec_positions.flatten(1)
  end

  def create_arr_of_column(col_num)
    cells.keys.select { |cell| cell.end_with?(col_num.to_s) }
  end

  def create_consec_cell_arrs(column_arrays, ship_length)
    column_arrays.each_cons(ship_length).map { |consec_cells| consec_cells }
  end

  ##############################################

  def consec_rows(tot_rows, ship_length)
    row_letter = 'A'
    consec_positions = 1.upto(tot_rows).map do
      row_arrays = create_arr_of_row(row_letter)
      row_letter.next!
      create_consec_row_cell_arrs(row_arrays, ship_length)
    end
    consec_positions.flatten(1)
  end

  def create_arr_of_row(row_letter)
    cells.keys.select { |cell| cell.start_with?(row_letter) }
  end

  def create_consec_row_cell_arrs(column_arrays, ship_length)
    column_arrays.each_cons(ship_length).map { |consec_cells| consec_cells }
  end
end
