require 'spec_helper'
require 'pry'

RSpec.describe Player do
  let(:player) { Player.new } 
  describe '#initialize' do
    it 'can initialize' do
      expect(player).to be_a(Player)
      expect(player.board).to be_a(Board)
      expect(player.fireable_cells).to eq(player.board.keys)
      expect(player.ships).to be_a(Hash)
      expect(player.ships[:cruiser]).to be_a(Ship)
      expect(player.ships[:cruiser].name).to eq("Cruiser")
      expect(player.ships[:cruiser].length).to eq(3)
      expect(player.ships[:submarine]).to be_a(Ship)
      expect(player.ships[:submarine].name).to eq("Submarine")
      expect(player.ships[:submarine].length).to eq(2)
    end
  end

  
  describe '#place' do
    it 'can place a piece with correct coordinates' do
      player.place(:cruiser, ['A1', 'A2', 'A3'])
      expect(player.board.cells['A1'].ship).not_to be_nil
      expect(player.board.cells['A2'].ship).not_to be_nil
      expect(player.board.cells['A3'].ship).not_to be_nil
    end

    it 'will return false if player inputs are invalid' do
      expect(player.place(:cruiser, ['A1', 'B2', 'C3'])).to be_nil
    end
  end
  
  # Move #render_board to subclasses
  # describe '#render_board' do
  #   it 'will render board with ships displayed' do
  #     expect(player.render_board).to eq(("  1 2 3 4 \n" + "A . . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"))
  #     player.place(:cruiser, ['A1', 'A2', 'A3'])
  #     expect(player.render_board).to eq("  1 2 3 4 \n" + "A S S S . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n")
  #   end
  # end

  # Move #turn to Game class
  # describe '#take_turn' do
  #   xit 'can take a turn' do

  #   end
  # end

  describe '#fire' do
    it 'will fire upon the board' do
      player.fire("A1")
      expect(player.board.render).to eq(("  1 2 3 4 \n" + "A M . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"))
    end

    xit 'will return false if the cell has already been fired on' do
      player.fire("A1")
      expect.(player.fire("A1")).to be_nil
    end
    xit 'can fire upon an opponents board' do
      ai = AI.new
      player.fire("A1")
      expect(ai.board.render).to eq(("  1 2 3 4 \n" + "A M . . . \n" + "B . . . . \n" + "C . . . . \n" + "D . . . . \n"))
    end
  end

  describe '#total_health' do
    it 'will find the sum of the health of all ships in the array' do
      expect(player.total_health).to eq(5)
    end

    it 'will find the current total after a ship takes a hit' do
      player.place(:cruiser, ['A1', 'A2', 'A3'])
      player.fire("A1")
      expect(player.total_health).to eq(4)
    end
  end
end