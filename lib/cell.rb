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

  def render(reveal = false)
    if !@fired && @ship.nil?
      "." 
    elsif !@fired && !@ship.nil?
      if reveal
        "S"
      else
        "."
      end
    elsif @fired && @ship.nil?
      "M" 
    elsif @fired && !@ship.nil? && !@ship.sunk?
      "H" 
    elsif @fired && !@ship.nil? && @ship.sunk?
      "X"
    end
  end
end