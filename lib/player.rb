class Player
  attr_reader :board,
              :fireable_cells,
              :ships
  def initialize
    @board = Board.new
    @fireable_cells = @board.keys
    @ships = [cruiser = Ship.new("Cruiser", 3), submarine = Ship.new("Submarine", 2)]
  end

  def place(name, coordinates)
    ship = ships.find { |ship| ship.name == name.capitalize}
    @board.place(ship, coordinates)
  end

end