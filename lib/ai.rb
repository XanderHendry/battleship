require './lib/player.rb'

class AI < Player

  def render_board
    @board.render
  end

  def place_ships
    coordinates = select_placement_coordinates(:cruiser)
    place(:cruiser, coordinates)
    coordinates = select_placement_coordinates_submarine
    place(:submarine, coordinates)
  end

  def select_placement_coordinates(ship)
    orientation = [:c_horizontal, :c_vertical].sample
    self.send(orientation)
  end

  def select_placement_coordinates_submarine
    orientation = [:s_horizontal, :s_vertical].sample
    coordinates = self.send(orientation)
    until @board.valid_placement?(ships[:submarine], coordinates) == true
      orientation = [:s_horizontal].sample
      coordinates = self.send(orientation)
    end
    coordinates
  end
  

  def c_horizontal
    first = ["A1", "A2", "B1", "B2", "C1", "C2", "D1", "D2"].sample
    second = first.split("")[0]+first.split("")[1].next
    third = first.split("")[0]+first.split("")[1].next.next
    [first, second, third]
  end

  def c_vertical
    first = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4"].sample
    second = first.split("")[0].next+first.split("")[1]
    third = first.split("")[0].next.next+first.split("")[1]
    [first, second, third]
  end

  def s_horizontal
    first = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3", "D1", "D2", "D3"].sample
    second = first.split("")[0]+first.split("")[1].next
    [first, second]
  end

  def s_vertical
    first = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4"].sample
    second = first.split("")[0].next+first.split("")[1]
    [first, second]
  end
end