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
end