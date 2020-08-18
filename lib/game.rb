require './lib/computer'

class Game
  attr_accessor :computer

  def initialize
    @computer = Computer.new
    display_menu
  end

  def display_menu
    puts 'Welcome to BATTLESHIP'
    play_or_quit
  end

  def play_or_quit
    loop do
      puts 'Enter p to play. Enter q to quit.'
      user_selection = gets.chomp

      if user_selection == 'p'
        play_game
        break
      end

      break if user_selection == 'q'
    end
  end

  def place_computer_ships
    computer.place_ships
    puts 'I have laid out my ships on the grid.'
  end

  def play_game
    place_computer_ships
    place_player_ships
  end
end

# game = Game.new
# puts game.computer.board.render(true)
