class Game
  def initialize
    @player1 = Human.new
    @player2 = AI.new
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter c for custom game. Enter q to quit."
    input = gets.upcase.chomp
    if input == "P"
      setup 
    elsif input == "C"
      custom_game
    elsif input == "Q"
      return 
    else
      main_menu
    end
  end

  def setup
    @player2.place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships. Press enter to continue.."
    gets
    render
    @player1.place_ships
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

  def turn
    human_turn
    ai_turn
  end

  def human_turn
    puts "Enter the coordinate for your shot:"
    coordinate = gets.upcase.chomp
    until @player2.board.valid_coordinate?(coordinate) && @player1.fireable_cells.include?(coordinate)
      puts "Please enter a valid coordinate:"
      coordinate = gets.upcase.chomp
    end
    @player2.fire(coordinate)
    @player1.fireable_cells.delete(coordinate)
    render
    feedback(@player2, coordinate)
    gets
  end

  def ai_turn
    coordinate = @player2.fireable_cells.sample
    puts "My turn. I am firing on #{coordinate}. Press enter to continue.."
    gets
    @player1.fire(coordinate)
    @player2.fireable_cells.delete(coordinate)
    render
    feedback(@player1, coordinate)
    puts "Press enter to continue.."
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

  def custom_game
    puts "Customize board size?"
    puts "Y/N"
    input = gets.upcase.chomp
    if input == "Y"
      puts "Enter board size. (Max 10)"
      input = gets.to_i
      range = (4..10)
      until range.include?(input) == true 
        puts "invalid board size! please try again!"
        input = gets.to_i
        if input == "QUIT"
          main_menu
          break
        end
      end
      length = input
      width = input
      @player1 = Human.new(length, width)
      @player2 = AI.new(length,width)
      setup
    else
      main_menu
    end
  end
    
end