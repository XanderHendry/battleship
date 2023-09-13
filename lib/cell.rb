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
      "\e[44m#{"."}\e[0m" 
    elsif !@fired && !@ship.nil?
      if reveal
        "\e[47m#{"S"}\e[0m"
      else
        "\e[44m#{"."}\e[0m"
      end
    elsif @fired && @ship.nil?
      "\e[44m#{"\e[32m#{"M"}\e[0m"}\e[0m" 
    elsif @fired && !@ship.nil? && !@ship.sunk?
      "\e[47m#{"\e[5m#{"\e[31m#{"H"}\e[0m"}\e[25m"}\e[0m" 
    elsif @fired && !@ship.nil? && @ship.sunk?
      "\e[44m#{"\e[37m#{"X"}\e[0m"}\e[0m"
    end
  end
end