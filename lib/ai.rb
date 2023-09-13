require './lib/player.rb'

class AI < Player
  attr_reader :difficulty,
              :fired_shots
  def initialize(length = 4, width = 4)
    super 
    @difficulty = "Normal"
    @fired_shots = []
    @opponent = @@players[0]
  end


  def render_board
    @board.render
  end

  def place_ships
    @ships.each do |ship|
      coordinates = select_placement_coordinates(ship)
      place(ship, coordinates)
    end
  end

  def select_placement_coordinates(ship)
    orientation = [:horizontal, :vertical].sample
    coordinates = self.send(orientation, ship)
    until @board.valid_placement?(ship, coordinates) == true
      orientation = [:horizontal, :vertical].sample
      coordinates = self.send(orientation, ship)
    end
    coordinates
  end

  def horizontal(ship)
    first = @board.grid_maker(@board.length, (@board.width - ship.length + 1)).sample
    placement = [first]
    previous_coordinate = first
    (ship.length - 1).times do 
      next_coordinate = previous_coordinate.split("")[0]+previous_coordinate.split("")[1].next
      placement << next_coordinate
      previous_coordinate = next_coordinate
    end
    placement
  end

  def vertical(ship)
    first = @board.grid_maker((@board.length - ship.length + 1), @board.width).sample
    placement = [first]
    previous_coordinate = first
    (ship.length - 1).times do 
      next_coordinate = previous_coordinate.split("")[0].next+previous_coordinate.split("")[1]
      placement << next_coordinate
      previous_coordinate = next_coordinate
    end
    placement
  end

  def pick_shot
    case @difficulty
    when "Normal"
      # binding.pry
      coordinate = normal_shot
    when "Medium"
      # binding.pry
      if @fired_shots == []
        coordinate = normal_shot
      else
        case @fired_shots.last.render
        when "\e[47m\e[5m\e[31mH\e[0m\e[25m\e[0m"
          coordinate = educated_guess(@fired_shots.last.coordinate)
        when "\e[44m#{"\e[32m#{"M"}\e[0m"}\e[0m"
          coordinate = normal_shot
        when "\e[44m#{"\e[37m#{"X"}\e[0m"}\e[0m" 
          coordinate = normal_shot
        end
      end
    end
  end

  def normal_shot
    coordinate = fireable_cells.sample
    @fired_shots << @opponent.board.cells[coordinate]
    fireable_cells.delete(coordinate)
    coordinate    
  end

  def educated_guess(last)
    last = last.split('')
    options = [(last[0] + last[1].next), (last[0].next + last[1]), (last[0].succ + last[1]), (last[0] + last[1].succ)]
    coordinate = options.sample
    until @fireable_cells.include?(coordinate)
      coordinate = options.sample
    end
    @fired_shots << @opponent.board.cells[coordinate]
    coordinate
  end

  def change_difficulty(input)
    # options = ["N", "M"]
    # puts "Enter n for normal. Enter m for Medium"
    # input = gets.upcase.chomp
    # until options.includes?(input)
    #   puts "invalid option please choose between /n (n, m)"
    #   input = gets.upcase.chomp
    # end
    case input
    when "N"
      @difficulty = "Normal"
    when "M"
      @difficulty = "Medium"
    end
  end

  def self.players
    super
  end

  def self.clear
    super
  end
end