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

  describe '#render_board' do
    it 'will render Human board' do
      expect(human.render_board).to eq(("  1 2 3 4 \n" + "A . . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"))
    end
    
    it 'will render board with ships displayed' do
      expect(human.render_board).to eq(("  1 2 3 4 \n" + "A . . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"))
      human.place(:cruiser, ['A1', 'A2', 'A3'])
      expect(human.render_board).to eq("  1 2 3 4 \n" + "A S S S . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n")
    end
  end

  describe '#place' do
    it 'can place a piece with correct coordinates' do
      human.place(:cruiser, ['A1', 'A2', 'A3'])
      expect(human.board.cells['A1'].ship).not_to be_nil
      expect(human.board.cells['A2'].ship).not_to be_nil
      expect(human.board.cells['A3'].ship).not_to be_nil
    end

    it 'will return false if player inputs are invalid' do
      expect(human.place(:cruiser, ['A1', 'B2', 'C3'])).to be_nil
    end
  end

  xdescribe '#fire' do
    xit 'can fire upon an opponents board' do
      ai = AI.new
      human.fire("A1")
      expect(ai.board.render).to eq(("  1 2 3 4 \n" + "A M . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"))
    end 
    
    xit 'will return false if the cell has already been fired on' do
      ai = AI.new
      human.fire("A1")
      expect.(human.fire("A1")).to be_nil
    end
  end
end