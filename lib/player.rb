require './lib/board'
require './lib/ship'

class Player
  attr_reader :board, :cells, :cruiser, :submarine, :shots_taken

  def initialize
    @board = Board.new
    @cells = board.cells
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @shots_taken = []
  end

  def place_ships
    puts 'You now need to lay out your two ships.'
    puts "The Cruiser is three units long and the Submarine is two units long.\n\n"
    puts board.render
    place_ship(cruiser)
    place_ship(submarine)
  end

  def place_ship(ship)
    puts "\nEnter squares for the #{ship.name} (#{ship.length} spaces)"

    loop do
      user_coordinates = gets.chomp.split(' ')
      if board.valid_placement?(ship, user_coordinates)
        board.place(ship, user_coordinates)
        puts
        puts board.render(true)
        break
      end

      puts "\nThose are invalid coordinates. Please try again:"
    end
  end

  def lost?
    cruiser.sunk? && submarine.sunk?
  end
end
