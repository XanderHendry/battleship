class Board
  attr_reader :cells
  def initialize(length = 4, width = 4)
    @cells = cell_maker(length, width)
  end

  def grid_maker(length, width)
    width = width - 1
    l = "A"
    cells = []
    length.times do
      w = "1"
      coordinate = [l , w].join    
      cells << coordinate
      width.times do
        w = w.next
        coordinate = [l, w].join
        cells << coordinate
      end
      l = l.next
      coordinate = [l, w].join
    end
    cells
  end

  def cell_maker(length, width)
    grid = grid_maker(length, width)
    grid.reduce({}) { |cells, name| cells[name] = Cell.new(name); cells}
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    valid_length?(ship, coordinates) && 
    consecutive?(ship, coordinates) && 
    not_diagonal?(ship, coordinates) && 
    all_vacant?(ship, coordinates) &&
    coordinates.all? { |coordinate| valid_coordinate?(coordinate) }
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
    return false if coordinates.uniq.count != coordinates.count
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

  def keys
    @cells.keys
  end
end