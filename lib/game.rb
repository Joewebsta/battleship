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
    puts "\nWelcome to BATTLESHIP"
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
    loop do
      if player.lost? || computer.lost?
        puts game_over
        break
      end

      display_boards
      player.shots_taken << player_shot
      computer.shots_taken << computer_shot
      display_turn_results
    end
  end

  def display_boards
    puts '=============COMPUTER BOARD============='
    puts computer.board.render
    puts '==============PLAYER BOARD=============='
    puts player.board.render(true)
  end

  def player_shot
    puts "\nEnter the coordinate for your shot:"

    loop do
      shot_coordinate = gets.chomp

      if coord_already_shot?(shot_coordinate)
        puts 'You have already fired upon this coordinate. Please provide another coordinate:'
        next
      end

      if player.board.valid_coordinate?(shot_coordinate)
        computer.cells[shot_coordinate].fire_upon
        return shot_coordinate
      end
      puts 'Please enter a valid coordinate:'
    end
  end

  def computer_shot
    shot_coordinate = computer.remaining_coordinates.sample
    player.cells[shot_coordinate].fire_upon
    computer.remaining_coordinates.delete(shot_coordinate)
    shot_coordinate
  end

  def display_turn_results
    puts display_player_results
    puts display_computer_results
  end

  def display_player_results
    last_shot_coord = player.shots_taken.last
    last_cell = computer.cells[last_shot_coord]
    cell_render = last_cell.render

    output = "\nYour shot on #{last_shot_coord} was a "
    output += 'miss.' if cell_render == 'M'
    output += 'hit.' if cell_render.include?('H') || cell_render.include?('X')
    output += " You sunk the computer's #{last_cell.ship.name}." if cell_render == 'X'
    output
  end

  def display_computer_results
    last_shot_coord = computer.shots_taken.last
    last_cell = player.cells[last_shot_coord]
    cell_render = last_cell.render

    output = "The computer's shot on #{last_shot_coord} was a "
    output += 'miss.' if cell_render == 'M'
    output += 'hit.' if cell_render.include?('H') || cell_render.include?('X')
    output += " It sunk your #{last_cell.ship.name}." if cell_render == 'X'
    output
  end

  def game_over
    player.lost? ? "\nThe computer won!\n" : "\nYou won!\n"
  end

  def place_computer_ships
    computer.place_ships
    puts
    puts 'The computer has laid out its ships on the grid.'
    puts
  end

  def place_player_ships
    player.place_ships
  end

  def coord_already_shot?(shot_coordinate)
    player.shots_taken.include?(shot_coordinate)
  end
end