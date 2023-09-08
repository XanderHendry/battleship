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
    valid_length?(ship, coordinates) && 
    consecutive?(ship, coordinates) && 
    not_diagonal?(ship, coordinates) && 
    all_vacant?(ship, coordinates)
  end

  def valid_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def conhelper(split, position)
    base = split.map {|num| num[position]}
    range = (base.first)..(base.last)
    range.to_a.length == base.length
  end

  def consecutive?(ship, coordinates)
    split = coordinates.map {|elements| elements.split('') }
    if split.all? { |element| element[0] == split[0][0] }
      conhelper(split, 1)
    elsif split.all? { |element| element[1] == split[0][1]}
      conhelper(split, 0)
    else 
      false
    end
  end

  def not_diagonal?(ship, coordinates)
    split = coordinates.map {|elements| elements.split('') }
    split.all? { |element| element[0] == split[0][0] } || split.all? { |element| element[1] == split[0][1]}
  end
  
  def all_vacant?(ship, coordinates)
    coordinates.all? { |key| @cells[key].empty? }
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        cell = cells[coordinate]
        cell.place_ship(ship)
      end
    end
  end

  def render(reveal = false)
    "  1 2 3 4 \n" +
    "A #{r("A1", reveal)} #{r("A2", reveal)} #{r("A3", reveal)} #{r("A4", reveal)} \n" +
    "B #{r("B1", reveal)} #{r("B2", reveal)} #{r("B3", reveal)} #{r("B4", reveal)} \n" +
    "C #{r("C1", reveal)} #{r("C2", reveal)} #{r("C3", reveal)} #{r("C4", reveal)} \n" +
    "D #{r("D1", reveal)} #{r("D2", reveal)} #{r("D3", reveal)} #{r("D4", reveal)} \n"
  end

  def r(cell, reveal = false)
    @cells[cell].render(reveal)
  end


end