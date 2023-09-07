require 'spec_helper'

RSpec.describe Ship do
  let(:ship) { Ship.new("Cruiser", 3) }
  describe '#initialize' do
    it 'can initialize' do
      expect(ship).to be_a(Ship)
      expect(ship.name).to eq("Cruiser")
      expect(ship.length).to eq(3)
      expect(ship.health).to eq(ship.length)
    end
  end
  
  describe '#hit' do
    it 'remove a single point of health from a ship' do
      expect(ship.health).to eq(3)
      ship.hit
      expect(ship.health).to eq(2)
    end
  end

  describe '#sunk?' do
    it 'will default as false' do
      expect(ship.sunk?).to eq(false)
    end

    it 'will return true when ship health is at 0' do
      ship.hit
      expect(ship.sunk?).to be false
      ship.hit
      expect(ship.sunk?).to be false
      ship.hit
      expect(ship.health).to eq(0)
      expect(ship.sunk?).to be true
    end
    
    it 'will work for ships starting with different health' do
      acc = Ship.new("Air Craft Carrier", 4)
      expect(acc.health).to eq(4)
      acc.hit
      acc.hit
      acc.hit
      acc.hit
      expect(acc.health).to eq(0)
      expect(acc.sunk?).to be true
    end
  end
end