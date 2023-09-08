require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("A1")
    @ship = Ship.new("Cruiser", 3)
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
    it 'will return true if Cell has no Ship (describeault)' do
      expect(@cell.empty?).to eq(true)
    end

    it 'will return false if Cell has a Ship' do
      @cell.place_ship(@ship)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#fired upon?' do
    it 'will return false if a cell has not been fired upon (describeault)' do
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

    it 'will damage a ship if the cell holds one' do.
      @cell.place_ship(@ship)
      expect(@cell.ship.health).to eq(3)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be true
    end

    it 'will not fire upon a cell more than once' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
      expect(@cell.fire_upon).to eq(false)
    end
  end

  describe '#render' do
    it 'will return "." if the cell had not been fired upon and has no ship' do
    end  

    it 'will return "S" if the cell had not been fired upon and contains a ship' do
    end  

    it 'will return "M" if the cell had been fired upon and has no ship' do
    end 
     
    it 'will return "H" if the cell has been fired upon and contains a non-sunk ship' do
    end

    it 'will return "H" if the cell has been fired upon and contains a sunk ship' do
    end 

end