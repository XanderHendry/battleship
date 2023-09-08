require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@board).to be_a(Board)
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.length).to eq(16)
      @board.cells.keys.each do |cell_name|
        expect(cell_name).to be_a(String)
      end
      @board.cells.values.each do |cell|
        expect(cell).to be_a(Cell)
      end
    end
  end

  describe '#valid_coordinate?' do

  end

  
end