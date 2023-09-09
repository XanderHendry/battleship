class Player
  attr_reader :board,
              :fireable_cells,
              :ships
  def initialize
    @board = Board.new
    @fireable_cells = @board.keys
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
  end

end