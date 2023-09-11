class Game
  def initialize
    @player1 = Human.new
    @player2 = AI.new
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
    @player2.place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    gets
    render
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "Enter the squares for the Cruiser (3 spaces):"
    coordinates = gets.chomp.split(" ")
    ship = @player1.ships[:cruiser]
    until @player1.board.valid_placement?(ship, coordinates)
      puts "Those are invalid coordinates. Please try again"
      coordinates = gets.chomp.split(" ")
    end
    @player1.place(:cruiser, coordinates)
    render
    puts "Enter the squares for the Submarine (2 spaces):"
    coordinates = gets.chomp.split(" ")
    ship = @player1.ships[:submarine]
    until @player1.board.valid_placement?(ship, coordinates)
      puts "Those are invalid coordinates. Please try again"
      coordinates = gets.chomp.split(" ")
    end
    @player1.place(:submarine, coordinates)
    render
    gameplay
  end

  def gameplay
    until @player1.ship_health == 0 || @player2.ship_health == 0
      human_turn 
      unless @player2.ship_health == 0
        ai_turn
      end
    end
    end_game
  end

  def end_game
    if @player1.ship_health == 0
      puts "I won!"
      gets
    else
      puts "You won!"
      gets
    end
    main_menu
  end

  def render
    system("clear")
    puts "=============COMPUTER BOARD============="
    puts @player2.render_board
    puts "==============PLAYER BOARD=============="
    puts @player1.render_board
  end

  # def turnq
  #   human_turn
  #   ai_turn
  # end

  def human_turn
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp
    until @player2.board.valid_coordinate?(coordinate) && @player1.fireable_cells.include?(coordinate)
      puts "Please enter a valid coordinate:"
      coordinate = gets.chomp
    end
    @player2.fire(coordinate)
    @player1.fireable_cells.delete(coordinate)
    render
    feedback(@player2, coordinate)
    gets
  end

  def ai_turn
    coordinate = @player2.fireable_cells.sample
    puts "My turn. I am firing on #{coordinate}."
    gets
    @player1.fire(coordinate)
    @player2.fireable_cells.delete(coordinate)
    render
    feedback(@player1, coordinate)
    gets
  end

  def feedback(player, coordinate)
    pronoun_hash = Hash.new
    if player.class == Human
      pronoun_hash[:possessive] = "My"
      pronoun_hash[:subject] = "I"
      pronoun_hash[:opp_possessive] = "your"
    elsif player.class == AI
      pronoun_hash[:possessive] = "Your"
      pronoun_hash[:subject] = "You"
      pronoun_hash[:opp_possessive] = "my"
    end
    case player.board.cells[coordinate].render
    when "H"
      puts "#{pronoun_hash[:possessive]} shot on #{coordinate} was a hit"
    when "M"
      puts "#{pronoun_hash[:possessive]} shot on #{coordinate} was a miss"
    when "X" 
      puts "#{pronoun_hash[:possessive]} shot on #{coordinate} was a hit"
      puts "#{pronoun_hash[:subject]} sunk one of #{pronoun_hash[:opp_possessive]} ships"
    end
  end
end