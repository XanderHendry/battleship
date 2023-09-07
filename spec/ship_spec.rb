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

  end
end