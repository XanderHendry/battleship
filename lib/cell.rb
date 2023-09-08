class Cell
  attr_reader :coordinate,
              :ship
  def initialize(coordinate)
  @coordinate = coordinate
  @ship = nil
  @fired = false
  end

  def place_ship(ship)
    @ship = ship
  end

  def empty?
    @ship.nil?
  end

  def fire_upon
    if fired_upon? == false
      @fired = true
      if !@ship.nil?
        @ship.hit
      end
    end
  end

  def fired_upon?
   @fired
  end
end