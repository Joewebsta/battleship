require './lib/cell'

class Board
  attr_reader :cells

  def initialize(grid_size = 4)
    @cells = create_cells(grid_size)
  end

  def create_cells(num)
    ('A'..(64 + num).chr).each_with_object({}) do |letter, cells|
      (1..num).each do |number|
        coordinate = "#{letter}#{number}"
        cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    cells.key?(coordinate)
  end

  #   def valid_placement?(ship, coordinates)
  #     ship_length = ship.length
  #     tot_rows = Math.sqrt(cells.length).to_i

  #     if valid_length?(ship_length, coordinates)
  #       true
  #     else
  #       false
  #     end

  #     if valid_consecutive_cells?(tot_rows, ship_length, coordinates)
  #       true
  #     else
  #       false
  #     end
  #   end

  #   def valid_length?(ship_length, coordinates)
  #     ship_length == coordinates.length
  #   end

  #   def valid_consecutive_cells?(tot_rows, ship_length, coordinates)
  #     valid_consec_positions = consec_rows(tot_rows, ship_length) + consec_cols(tot_rows, ship_length)
  #     valid_consec_positions.one? { |position| position == coordinates }
  #   end

  #   def consec_cols(tot_rows, ship_length)
  #     consec_positions = 1.upto(tot_rows).map do |i|
  #       column_arrays = create_arr_of_row_col(i)
  #       create_consec_row_col_cell_arrs(column_arrays, ship_length)
  #     end

  #     consec_positions.flatten(1)
  #   end

  #   def consec_rows(tot_rows, ship_length)
  #     row_letter = 'A'
  #     consec_positions = 1.upto(tot_rows).map do
  #       row_arrays = create_arr_of_row_col(row_letter)
  #       row_letter.next!
  #       create_consec_row_col_cell_arrs(row_arrays, ship_length)
  #     end

  #     consec_positions.flatten(1)
  #   end

  #   def create_arr_of_row_col(char)
  #     cells.keys.select { |cell| cell.include?(char.to_s) }
  #   end

  #   def create_consec_row_col_cell_arrs(row_col_arrays, ship_length)
  #     row_col_arrays.each_cons(ship_length).map { |consec_cells| consec_cells }
  #   end

  #   def place(ship, coordinates)
  #     return false unless valid_placement?(ship, coordinates)

  #     coordinates.each do |coordinate|
  #       cells[coordinate].place_ship(ship)
  #     end
  #   end
end
