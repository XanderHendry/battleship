require 'pry'
require 'spec_helper'

RSpec.describe Human do
  let(:human) { Human.new }
  it 'is a descendant of Player' do
    expect(Human.superclass).to eq(Player)
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(human).to be_a(Human)
      expect(human.board).to be_a(Board)
      expect(human.fireable_cells).to eq(human.board.keys)
      expect(human.ships).to be_a(Hash)
      expect(human.ships[:cruiser]).to be_a(Ship)
      expect(human.ships[:cruiser].name).to eq("Cruiser")
      expect(human.ships[:cruiser].length).to eq(3)
      expect(human.ships[:submarine]).to be_a(Ship)
      expect(human.ships[:submarine].name).to eq("Submarine")
      expect(human.ships[:submarine].length).to eq(2)
    end
  end
end