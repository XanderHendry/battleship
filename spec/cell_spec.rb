require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("A1")
    @ship = Ship.new("Cruiser", 3)
  def '#initialize' do
    it 'can initialize' do
      expect(@cell).to be_a(Cell)
      expect(@cell.coordinate).to eq("A1")
      expect(@cell.ship).to be_nil
    end
  end

  def '#place ship' do
    it 'will add a ship to a cell' do
      expect(@cell.ship).to be_nil
      @cell.place_ship(@ship)
      expect(@cell.ship).to eq(@ship)
    end
  end

  def '#empty?' do
    it 'will return true if Cell has no Ship (default)' do
      expect(@cell.empty?).to eq(true)
    end

    it 'will return false if Cell has a Ship' do
      @cell.place_ship(@ship)
      expect(@cell.empty?).to eq(false)
    end
  end
end