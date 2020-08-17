class Game
  def display_menu
    puts 'Welcome to BATTLESHIP'
    play_or_quit
  end

  def play_or_quit
    loop do
      puts 'Enter p to play. Enter q to quit.'
      user_selection = gets.chomp

      break if user_selection == 'q'

      play_game if user_selection == 'p'
      break
    end
  end

  def play_game; end
end
