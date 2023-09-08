require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("A1")
    @ship = Ship.new("Cruiser", 3)
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@cell).to be_a(Cell)
      expect(@cell.coordinate).to eq("A1")
      expect(@cell.ship).to be_nil
    end
  end

  describe '#place ship' do
    it 'will add a ship to a cell' do
      expect(@cell.ship).to be_nil
      @cell.place_ship(@ship)
      expect(@cell.ship).to eq(@ship)
    end
  end

  describe '#empty?' do

    it 'will return true if Cell has no Ship (default)' do
      expect(@cell.empty?).to eq(true)
    end

    it 'will return false if Cell has a Ship' do
      @cell.place_ship(@ship)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#fired upon?' do
    it 'will return false if a cell has not been fired upon (default)' do
      expect(@cell.fired_upon?).to eq(false)
    end

    it 'will return true if a cell has been fired upon' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe '#fire upon' do
    it 'will fire upon a cell' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end

    it 'will damage a ship if the cell holds one' do
      @cell.place_ship(@ship)
      expect(@cell.ship.health).to eq(3)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be true
    end

    it 'will not fire upon a cell more than once' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
      expect(@cell.fire_upon).to be_nil
    end
  end

  describe '#render' do
    it 'will return "." if the cell had not been fired upon and has no ship' do
      expect(@cell.render).to eq(".")
    end  
    
    it 'will return "." if the cell had not been fired upon and contains a ship' do
      @cell.place_ship(@ship)
      expect(@cell.render).to eq(".")
    end 
    
    it 'will return "S" if the cell had not been fired upon and contains a ship with the optional argument true' do
      @cell.place_ship(@ship)
      expect(@cell.render(true)).to eq("S")
    end  
    
    it 'will return "M" if the cell had been fired upon and has no ship' do
      @cell.fire_upon
      expect(@cell.render).to eq("M")
    end 
    
    it 'will return "H" if the cell has been fired upon and contains a non-sunk ship' do
      @cell.place_ship(@ship)
      @cell.fire_upon
      expect(ship.sunk?).to be false
      expect(@cell.render).to eq("H")
    end

    it 'will return "X" if the cell has been fired upon and contains a sunk ship' do
      ship = Ship.new("buoy", 1)
      @cell.place_ship(ship)
      @cell.fire_upon
      expect(ship.sunk?).to be true
      expect(@cell.render).to eq("X")
    end 
  end
end