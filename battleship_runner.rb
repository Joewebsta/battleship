require './lib/game'

puts "\nWelcome to BATTLESHIP"

loop do
  puts 'Enter p to play. Enter q to quit.'
  user_selection = gets.chomp

  if user_selection.downcase == 'p'
    game = Game.new
    game.play_game
  end

  next unless user_selection.downcase.include?('q')
  break if user_selection.downcase == 'q'
end
