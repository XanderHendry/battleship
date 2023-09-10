require 'pry'
require 'spec_helper'

RSpec.describe AI do
  let(:ai) { AI.new }
  it 'is a descendant of Player' do
    expect(AI.superclass).to eq(Player)
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(ai).to be_a(AI)
      expect(ai.board).to be_a(Board)
      expect(ai.fireable_cells).to eq(ai.board.keys)
      expect(ai.ships).to be_a(Hash)
      expect(ai.ships[:cruiser]).to be_a(Ship)
      expect(ai.ships[:cruiser].name).to eq("Cruiser")
      expect(ai.ships[:cruiser].length).to eq(3)
      expect(ai.ships[:submarine]).to be_a(Ship)
      expect(ai.ships[:submarine].name).to eq("Submarine")
      expect(ai.ships[:submarine].length).to eq(2)
    end
  end

  describe '#render_board' do
    it 'will render board with ships displayed' do
      expect(ai.render_board).to eq(("  1 2 3 4 \n" + "A . . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"))
      ai.place(:cruiser, ['A1', 'A2', 'A3'])
      expect(ai.render_board).to eq("  1 2 3 4 \n" + "A . . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n")
    end
  end

  describe '#select_placement_coordinates' do
    10.times do
      it 'will not choose invalid cordinates' do
        coordinates = ai.select_placement_coordinates(:cruiser)
        expect(ai.board.valid_placement?(ai.ships[:cruiser], coordinates)).to be true
        ai.place(:cruiser, coordinates)
        coordinates = ai.select_placement_coordinates(:submarine)
        expect(ai.board.valid_placement?(ai.ships[:submarine], coordinates)).to be true
      end
    end
  end
end