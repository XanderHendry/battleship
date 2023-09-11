class Board
  attr_reader :cells, :length, :width
  def initialize(length = 4, width = 4)
    @cells = cell_maker(length, width)
    @length = length
    @width = width
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
    "#{render_first_line}" +
    "#{render_board_body(reveal)}"
  end

  def render_first_line
    first_line = "  1 "
    last = 1
    (width - 1).times do
      pixel = last.next
      first_line += "#{pixel} "
      last = pixel
    end
    first_line += "\n"
  end

  def render_board_body(reveal = false)
    current_row = "A"
    body = render_body_row(current_row, reveal)
    (length-1).times do
      current_row = current_row.next
      row = render_body_row(current_row, reveal)
      body += row
    end
    body
  end

  def render_body_row(current_row, reveal = false)
    line = "#{current_row} "
    current_column = "1"
    length.times do
      cell = "#{current_row}#{current_column}"
      pixel = "#{r(cell, reveal)} "
      line += pixel
      current_column = current_column.next
    end
    line += "\n"
  end


  def r(cell, reveal = false)
    @cells[cell].render(reveal)
  end

  def keys
    @cells.keys
  end
end