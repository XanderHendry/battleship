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
      expect(player.ships[0]).to be_a(Ship)
      expect(player.ships[0].name).to eq("Cruiser")
      expect(player.ships[0].length).to eq(3)
      expect(player.ships[1]).to be_a(Ship)
      expect(player.ships[1].name).to eq("Submarine")
      expect(player.ships[1].length).to eq(2)
    end
  end

  
  describe '#place' do
    it 'can place a piece with correct coordinates' do
      player.place(player.ships[0], ['A1', 'A2', 'A3'])
      expect(player.board.cells['A1'].ship).not_to be_nil
      expect(player.board.cells['A2'].ship).not_to be_nil
      expect(player.board.cells['A3'].ship).not_to be_nil
    end

    it 'will return false if player inputs are invalid' do
      expect(player.place(player.ships[0], ['A1', 'B2', 'C3'])).to be_nil
    end
  end

  describe '#fire' do
    it 'will fire upon the players board' do
      expect(player.board.render).to eq("  1 2 3 4 \nA \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nB \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nC \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nD \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \n")
      player.fire('A1')
      expect(player.board.render).to eq("  1 2 3 4 \nA \e[44m#{"\e[32m#{"M"}\e[0m"}\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nB \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nC \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nD \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \n")
    end
  end

  describe '#ship_health' do
    it 'will find the sum of the health of all ships in the array' do
      expect(player.ship_health).to eq(5)
    end

    it 'will find the current ship after a ship takes a hit' do
      player.place(player.ships[0], ['A1', 'A2', 'A3'])
      player.fire("A1")
      expect(player.ship_health).to eq(4)
    end
  end

  describe '::players' do
    it 'will list all instances of Player subclasses' do
      Player.clear
      human = Human.new
      expect(Player.players).to eq([human])
      Player.clear
    end
  end

  describe '::clear' do
    it 'will clear the @@players array' do
      human = Human.new
      expect(Player.players.length).to eq(1)
      Player.clear
      expect(Player.players.length).to eq(0)
    end
  end
end