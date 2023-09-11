class Player
  attr_reader :board,
              :fireable_cells,
              :ships
  def initialize
    @board = Board.new
    @fireable_cells = @board.keys
    @ships = {cruiser: Ship.new("Cruiser", 3),
     submarine: Ship.new("Submarine", 2)}
  end
     
  def place(name, coordinates)
    @board.place(@ships[name], coordinates)
  end 
    
  def fire(coordinate)
    @board.cells[coordinate].fire_upon
  end
    
  def ship_health
    @ships.values.map{ |ship| ship.health}.sum
  end
end