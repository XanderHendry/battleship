require './lib/player.rb'

class AI < Player

  def render_board
    @board.render(true)
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
end