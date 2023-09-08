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
    it 'can determine when a given coordinate is within the board' do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
    end
    
    it 'can determine when a given coordinate is not within the board' do
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end

  describe '#valid_placement?' do
    describe '#valid_length?' do

    end

    describe '#consecutive?' do

    end

    describe '#diagonal?' do

    end

    describe '#overlap?' do

    end

    it 'passes all helper method placement checks' do

    end

  end
end