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

  xdescribe '#place ship' do
    it 'will add a ship to a cell' do
      expect(@cell.ship).to be_nil
      @cell.place_ship(@ship)
      expect(@cell.ship).to eq(@ship)
    end
  end

  xdescribe '#empty?' do
    it 'will return true if Cell has no Ship (defeault)' do
      expect(@cell.empty?).to eq(true)
    end

    it 'will return false if Cell has a Ship' do
      @cell.place_ship(@ship)
      expect(@cell.empty?).to eq(false)
    end
  end

  xdescribe '#fired upon?' do
    it 'will return false if a cell has not been fired upon (defeault)' do
      expect(@cell.fired_upon?).to eq(false)
    end

    it 'will return true if a cell has been fired upon' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  xdescribe '#fire upon' do
    it 'will fire upon a cell' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end

    it 'will damage a ship if the cell holds one' do
      @cell.place_ship(@ship)
      expect(@cell.ship.health).to eq(3)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
    end

    it 'will not fire upon a cell more than once' do
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
      expect(@cell.fire_upon).to eq(false)
    end
  end
end