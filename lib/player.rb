class Player
  attr_reader   :board,
                :fireable_cells
  attr_accessor :ships
  def initialize(length = 4, width = 4)
    @board = Board.new(length, width)
    @fireable_cells = @board.keys
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
  end
     
  def place(ship, coordinates)
    @board.place(ship, coordinates)
  end 
    
  def fire(coordinate)
    @board.cells[coordinate].fire_upon
  end
    
  def ship_health
    @ships.map{ |ship| ship.health}.sum
  end
end