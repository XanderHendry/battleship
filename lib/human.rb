require './lib/player.rb'

class Human < Player

  def render_board
    @board.render(true)
  end

  def place(ship, coordinates)
    super
  end

  # def fire(coordinates)
  #   super
  # end
end