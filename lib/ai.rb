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
    coordinate = fireable_cells.sample
    fireable_cells.delete(coordinate)
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