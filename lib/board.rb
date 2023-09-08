class Board
  attr_reader :cells
  def initialize(length = 4, width = 4)
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A2"),
      "A4" => Cell.new("A2"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    #runs all validation helper methods to validate placement of Ship objects"
  end

  def valid_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def consecutive?(ship, coordinates)
    split = coordinates.map {|elements| elements.split('') }
    if split.all? { |element| element[0] == split[0][0] }
      horizontal = split.map {|num| num[1].to_i}
      range = (horizontal.first)..(horizontal.last)
      range.to_a.length == horizontal.length
    elsif split.all? { |element| element[1] == split[0][1]}
      vertical = split.map {|letter| letter[0]}
      range = (vertical.first)..(vertical.last)
      range.to_a.length == vertical.length
    else 
      false
    end
  end

  def not_diagonal?(ship, coordinates)
    #validates that coordinates given will place ship in a straight line
  end
  
  def all_vacant?(ship, coordinates)
    #validates that there are no Ships ocupying any cell in the coordinates array
  end
end