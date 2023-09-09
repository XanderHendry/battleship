class Game
  def initialize
  #   @player1 = Human.new
  #   @player2 = AI.new
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp
    if input == "p"
      setup 
    elsif input == "q"
      return 
    else
      main_menu
    end
  end

  def setup
    player2.place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts player1.render_board
    puts "Enter the squares for the Cruiser (3 spaces):"
    coordinates = gets.chomp.split(" ")
    until player1.board.valid_placement?(player1.ships[0], coordinates)
      puts "Those are invalid coordinates. Please try again"
      coordinates = gets.chomp.split(" ")
    end
    player1.place(player1.ships[0], coordinates)
    puts "Enter the squares for the Submarine (2 spaces):"
    coordinates = gets.chomp.split(" ")
    until player1.board.valid_placement?(player1.ships[1], coordinates)
      puts "Those are invalid coordinates. Please try again"
      coordinates = gets.chomp.split(" ")
    end
    player1.place(player1.ships[1], coordinates)
  end
end