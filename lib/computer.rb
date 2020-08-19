require './lib/board'
require './lib/ship'

class Computer
  attr_reader :board, :cells, :cruiser, :submarine, :shots_taken, :remaining_coordinates

  def initialize
    @board = Board.new
    @cells = board.cells
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @shots_taken = []
    @remaining_coordinates = cells.keys
  end

  def place_ships
    place_ship(cruiser)
    place_ship(submarine)
  end

  def place_ship(ship)
    ship_length = ship.length
    loop do
      rand_coord = cells.values.sample.coordinate
      coords_arr = if rand(2).positive?
                     vert_coords(rand_coord, ship_length)
                   else
                     horiz_coords(rand_coord, ship_length)
                   end
      if board.valid_placement?(ship, coords_arr)
        board.place(ship, coords_arr)
        break
      end
    end
  end

  def lost?
    cruiser.sunk? && submarine.sunk?
  end

  # ***************** HELPER METHODS *****************

  def vert_coords(rand_coord, ship_length)
    coords_arr = []
    letter = rand_coord[0]
    digit = rand_coord[1]
    ship_length.times do
      coords_arr << letter + digit
      letter = letter.next
    end
    coords_arr
  end

  def horiz_coords(rand_coord, ship_length)
    coords_arr = []
    ship_length.times do
      coords_arr << rand_coord
      rand_coord = rand_coord.next
    end
    coords_arr
  end
end
