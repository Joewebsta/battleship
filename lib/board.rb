require './lib/cell'

class Board
  attr_reader :cells

  def initialize(grid_size = 4)
    @cells = create_cells(grid_size)
  end

  def create_cells(num)
    ('A'..(64 + num).chr).each_with_object({}) do |letter, cells|
      (1..num).each do |number|
        coord = "#{letter}#{number}"
        cells[coord] = Cell.new(coord)
      end
    end
  end

  def valid_coordinate?(coord)
    cells.key?(coord)
  end

  def valid_placement?(ship, coords_arr)
    valid_length?(ship, coords_arr) && consecutive_coordinates?(coords_arr)
  end

  def valid_length?(ship, coords_arr)
    ship.length == coords_arr.length
  end

  def consecutive_coordinates?(coords_arr)
    coord_letters = coords_arr.map { |coord| coord[0] }
    coord_nums = coords_arr.map { |coord| coord[1] }

    if identical_coord_letters?(coord_letters) # row coordinates
      consec_nums?(coord_nums)
    elsif identical_coord_nums?(coord_nums) # columm coordinates
      consec_letters?(coord_letters)
    else
      false
    end
  end

  # *********** HELPER METHODS ***********
  def identical_coord_letters?(coord_letters)
    coord_letters.uniq.length == 1
  end

  def identical_coord_nums?(coord_nums)
    coord_nums.uniq.length == 1
  end

  def consec_nums?(coord_nums)
    coord_nums.each_cons(2).all? do |coord_num1, coord_num2|
      coord_num1.ord + 1 == coord_num2.ord
    end
  end

  def consec_letters?(coord_letters)
    coord_letters.each_cons(2).all? do |coord_letter1, coord_letter2|
      coord_letter1.ord + 1 == coord_letter2.ord
    end
  end

  #   def place(ship, coordinates)
  #     return false unless valid_placement?(ship, coordinates)

  #     coordinates.each do |coordinate|
  #       cells[coordinate].place_ship(ship)
  #     end
  #   end
end
