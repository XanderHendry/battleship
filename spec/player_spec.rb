require 'spec_helper'
require 'pry'

RSpec.describe Player do
  let(:player) { Player.new } 
  describe '#initialize' do
    it 'can initialize' do
      expect(player).to be_a(Player)
      expect(player.board).to be_a(Board)
      expect(player.fireable_cells).to eq(player.board.keys)
      expect(player.ships).to be_a(Array)
      players.ships.each do |ship|
        expect(ship).to be_a(Ship)
      end
    end
  end

  describe '#render' do
    it 'will render board with ships displayed' do

    end
  end

  describe '#take_turn' do
    it 'can take a turn' do

    end
  end
end