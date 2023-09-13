require 'pry'
require 'spec_helper'

RSpec.describe AI do
  let(:ai) { AI.new }
  it 'is a descendant of Player' do
    expect(AI.superclass).to eq(Player)
  end
  describe '#initialize' do
    it 'initializes with inherited and additional attributes' do
      expect(ai).to be_a(AI)
      expect(ai.board).to be_a(Board)
      expect(ai.fireable_cells).to eq(ai.board.keys)
      expect(ai.ships).to be_a(Array)
      expect(ai.ships[0]).to be_a(Ship)
      expect(ai.ships[0].name).to eq("Cruiser")
      expect(ai.ships[0].length).to eq(3)
      expect(ai.ships[1]).to be_a(Ship)
      expect(ai.ships[1].name).to eq("Submarine")
      expect(ai.ships[1].length).to eq(2)
      expect(ai.difficulty).to eq("NORMAL")
      expect(ai.fired_shots).to eq([])
    end
  end

  describe '::players' do
    it 'will list all instances of Player subclasses' do
      human = Human.new
      expect(ai.players).to eq([ai, human])
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
        coordinates = ai.select_placement_coordinates(ai.ships[0])
        expect(ai.board.valid_placement?(ai.ships[0], coordinates)).to be true
        ai.place(ai.ships[0], coordinates)
        coordinates = ai.select_placement_coordinates(ai.ships[1])
        expect(ai.board.valid_placement?(ai.ships[1], coordinates)).to be true
      end
    end
  end

end