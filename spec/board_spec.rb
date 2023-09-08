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
    before(:each) do
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2) 
    end

    describe '#valid_length?' do
      it 'can determine when number of coordinates do not map ship length' do
        expect(@board.valid_length?(@cruiser, ["A1", "A2"])).to be false
        expect(@board.valid_length?(@submarine, ["A2", "A3", "A4"])).to be false
      end
    end

    describe '#consecutive?' do
      it 'can determine when an array of cells are not consecutive' do
        expect(@board.consecutive?(@cruiser, ["A1", "A2", "A4"])).to be false
        expect(@board.consecutive?(@submarine, ["A1", "C1"])).to be false
        expect(@board.consecutive?(@cruiser, ["A3", "A2", "A1"])).to be false
        expect(@board.consecutive?(@submarine, ["C1", "B1"])).to be false
      end
    end
      
    describe '#not_diagonal?' do
      it 'can determine when an array of cells are not diagonal' do
        expect(@board.not_diagonal?(@cruiser, ["A1", "B2", "C3"])).to be false
        expect(@board.not_diagonal?(@submarine, ["C2", "D3"])).to be false
      end
    end

    describe '#all_vacant?' do
      xit 'cam determine if all spaces are vacant' do
        @board.place(@cruiser, ["A1", "A2", "A3"])
        expect(@board.all_vacant?(@submarine, ["A1", "B1"])).to be false
      end
    end

    it 'passes all helper method placement checks' do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be true
    end
  end

  describe '#place' do
    before(:each) do
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2) 
    end

    it 'will place a ship on the board, taking up cells equal to its length' do
      @board.place(@cruiser, ['A1', 'A2', 'A3'])
      cell1 = @board.cells["A1"]
      cell2 = @board.cells["A2"]
      cell3 = @board.cells["A3"]
      cells = [cell1, cell2, cell3]
      cells.each do |cell|
        expect(cell.ship).to eq(@cruiser)
      end
    end

    it 'will integrate with validation methods' do
      @board.place(@cruiser, ['A1', 'A2', 'A3'])
      expect@board.place(@submarine, ['A3', 'B3']).to be_nil
      expect@board.place(@submarine, ['C3', 'B2']).to be_nil
      expect@board.place(@submarine, ['B3', 'D3']).to be_nil
      expect@board.place(@submarine, ['C1', 'C2', 'C3']).to be_nil
      @board.place(@submarine, ['B2', 'C2'])
      cell1 = @board.cells["A1"]
      cell2 = @board.cells["A2"]
      cell3 = @board.cells["A3"]
      cruiser_cells = [cell1, cell2, cell3]
      cruiser_cells.each do |cell|
        expect(cell.ship).to eq(@cruiser)
      end
      cell4 = @board.cells['B2']
      cell5 = @board.cells['C2']
      sub_cells = [cell4, cell5]
      sub_cells.each do |cell|
        expect(cell.ship).to eq(@submarine)
      end
    end
  end
end