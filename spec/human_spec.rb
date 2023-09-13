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
      expect(human.ships).to be_a(Array)
      expect(human.ships[0]).to be_a(Ship)
      expect(human.ships[0].name).to eq("Cruiser")
      expect(human.ships[0].length).to eq(3)
      expect(human.ships[1]).to be_a(Ship)
      expect(human.ships[1].name).to eq("Submarine")
      expect(human.ships[1].length).to eq(2)
    end
  end

  describe '#render_board' do
    it 'will render Human board' do
      expect(human.render_board).to eq("  1 2 3 4 \nA \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nB \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nC \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nD \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \n")
    end
    
    it 'will render board with ships displayed' do
      expect(human.render_board).to eq("  1 2 3 4 \nA \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nB \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nC \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nD \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \n")
      human.board.place(human.ships[0], ['A1', 'A2', 'A3'])
      expect(human.render_board).to eq("  1 2 3 4 \nA \e[47mS\e[0m \e[47mS\e[0m \e[47mS\e[0m \e[44m.\e[0m \nB \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nC \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \nD \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \e[44m.\e[0m \n")
    end
  end
end