require './lib/computer'
require './lib/player'

class Game
  attr_accessor :computer, :player

  def initialize
    @computer = Computer.new
    @player = Player.new
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

      if user_selection.downcase == 'p'
        play_game
        break
      end

      break if user_selection.downcase == 'q'
    end
  end

  def play_game
    place_computer_ships
    place_player_ships
    play_turn
  end

  def play_turn
    display_boards
    player.shots_taken << player_shot
    computer.shots_taken << computer_shot
  end

  def display_boards
    puts '=============COMPUTER BOARD============='
    puts computer.board.render
    puts '==============PLAYER BOARD=============='
    puts player.board.render(true)
  end

  def player_shot
    puts 'Enter the coordinate for your shot:'
    shot_coordinate = gets.chomp

    loop do
      if player.board.valid_coordinate?(shot_coordinate)
        computer.cells[shot_coordinate].fire_upon
        break
      end
      puts 'Please enter a valid coordinate:'
    end

    shot_coordinate
  end

  def computer_shot
    shot_coordinate = computer.remaining_coordinates.sample
    player.cells[shot_coordinate].fire_upon
    computer.remaining_coordinates.delete(shot_coordinate)
    shot_coordinate
  end

  def place_computer_ships
    computer.place_ships
    puts
    puts 'I have laid out my ships on the grid.'
    puts
  end

  def place_player_ships
    player.place_ships
  end
end

Game.new

# p player.cells[player.shots_taken.last].render
