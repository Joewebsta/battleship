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

  def place_computer_ships
    computer.place_ships
    puts
    puts 'I have laid out my ships on the grid.'
    puts
  end

  def place_player_ships
    player.place_ships
  end

  def play_game
    place_computer_ships
    place_player_ships
  end
end

Game.new
