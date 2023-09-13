class Game
  def initialize
    @player1 = Human.new
    @player2 = AI.new
  end

  def main_menu
    system("clear")
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter c for custom game. Enter q to quit."
    input = gets.upcase.chomp
    return if input == "Q"
    if input == "P"
      difficulty_query
      setup 
    elsif input == "C"
      custom_game
    elsif input == "Q"
      return 
    else
      main_menu
    end
  end

  def difficulty_query
    puts "Choose computer difficulty \n (Easy, Normal)"
    input_2 = gets.upcase.chomp
    until input_2 == "EASY" || input_2 == "NORMAL"
      puts "Invalid option, please choose between \n (Easy, Normal)"
      input_2 = gets.upcase.chomp
    end
    @player2.change_difficulty(input_2)
  end

  def setup
    system("clear")
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
  end

  def ai_turn
    coordinate = @player2.pick_shot
    puts "My turn. I am firing on #{coordinate}. Press enter to continue.."
    gets
    @player1.fire(coordinate)
    render
    feedback(@player1, coordinate)
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
    when "\e[47m#{"\e[5m#{"\e[31m#{"H"}\e[0m"}\e[25m"}\e[0m"
      puts "#{pronoun_hash[:possessive]} shot on #{coordinate} was a hit"
    when "\e[44m#{"\e[32m#{"M"}\e[0m"}\e[0m"
      puts "#{pronoun_hash[:possessive]} shot on #{coordinate} was a miss"
    when "\e[44m#{"\e[37m#{"X"}\e[0m"}\e[0m" 
      puts "#{pronoun_hash[:possessive]} shot on #{coordinate} was a hit"
      puts "#{pronoun_hash[:subject]} sunk one of #{pronoun_hash[:opp_possessive]} ships"
    end
  end

  def custom_game
    system("clear")
    puts "Customize board size?"
    input1 = yn?
    if input1 == "Y"
      custom_board_menu
    end
    system("clear")
    puts "Customize ships?"
    input2 = yn?
    if input2 == "Y"
      custom_ship_menu
    end
    if input1 == "N" && input2 == "N"
      main_menu
    end
    setup
  end

  def custom_board_menu
    system("clear")
    puts "Enter board size. (Max 9)"
    input = gets.to_i
    range = (4..9)
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
    render
    puts "Here is your #{length}x#{width} board"
    gets
  end

  def custom_ship_menu
    @player1.ships = []
    @player2.ships = []
    another_ship = "Y"
    current_ship = "1"
    system("clear")
    puts "Please enter the name of the ship"
    until another_ship == "N" || @player1.ship_health >= (0.5 * @player1.board.keys.count)
      ships = ship_shaper(current_ship)
      @player1.ships << ships[0]
      @player2.ships << ships[1]
      current_ship.next!
      if @player1.ship_health < (0.5 * @player1.board.keys.count)
        puts "Would you like to create another ship?"
        another_ship = yn?
        system("clear")
      else
        puts "Your ship yard is full."
      end
    end
    puts "Let's start placing ships."
  end

  def ship_shaper(current_ship)
    puts "Enter the name of ship number #{current_ship}."
    name = gets.chomp
    puts "Please enter then length of the ship. It must be between 2 and #{@player1.board.length - 1}"
    length = 0
    until (2..(@player1.board.length - 1)).include?(length)
      length = gets.to_i
    end
    [ship1 = Ship.new(name, length), ship2 = Ship.new(name, length)]
  end
 
  def yn?
    puts "(Y/N)"
    input = gets.upcase.chomp
    until input == "Y" || input == "N"
      puts "Please answer Y or N"
      input = gets.upcase.chomp
    end
    input
  end
end