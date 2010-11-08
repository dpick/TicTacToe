require File.dirname(__FILE__) + '/spec_helper'

describe "board tests" do
  before(:each) do
    @board = Board.new(3)
  end

  describe "initialization tests" do
    it "should make a board of size 3" do
      @board.size.should == 2 
    end

    it "should have an empty board" do
      @board.board.should == Array.new(3) { Array.new(3) { nil } }
    end
  end

  describe "open_space? tests" do
    it "should be true for all spaces after initialization" do
      (0..@board.size).each do |i|
        (0..@board.size).each do |j|
          @board.open_space?(i, j).should be_true
        end
      end
    end

    it "should be false if a space isn't nil" do
      @board.board[0][0] = 'x'
      @board.open_space?(0, 0).should be_false
    end
  end

  describe "make_move tests" do
    it "should make a move if the space is open" do
      valid, newBoard = @board.make_move(0, 0, 'x')
      newBoard.board[0][0].should == 'x'
    end

    it "should return false if a space is taken" do
      valid, newBoard = @board.make_move(0, 0, 'x')
      valid, newBoard = newBoard.make_move(0, 0, 'x')
      valid.should be_false
    end
  end

  describe "full? tests" do
    it "should be not be full if the board is empty" do
      @board.full?.should be_false
    end

    it "should be true if all spaces are taken" do
      @board.board = Array.new(3) { Array.new(3) { 'X' }}
      @board.full?.should be_true
    end
  end 

  describe "check_win_position tests" do
    it "should return true if all the elements in a list are the same" do
      list = ['x', 'x', 'x']
      @board.check_win_position(list).should be_true
    end

    it "should return false if all elements are nil" do
      list = [nil, nil, nil]
      @board.check_win_position(list).should be_false
    end

    it "should return false if there are multiple players in the list" do
      list = ['x', 'o', 'x']
      @board.check_win_position(list).should be_false
    end

    it "should return false if the list has nil elements" do
      list = ['x', nil, 'x']
      @board.check_win_position(list).should be_false
    end
  end

  describe "win_in_row_or_col? row tests" do
    it "should return true if there is a win in the first row" do
      @board.board[0] = ['x'] * 3
      @board.win_in_row_or_col?(@board.board).should be_true
    end

    it "should return true if there is a win in the second row" do
      @board.board[1] = ['x'] * 3
      @board.win_in_row_or_col?(@board.board).should be_true
    end

    it "should return true if there is a win in the third row" do
      @board.board[2] = ['x'] * 3
      @board.win_in_row_or_col?(@board.board).should be_true
    end

    it "should return false if there is not a win" do
      @board.win_in_row_or_col?(@board.board).should be_false
    end

    it "should return false if there is not a win" do
      @board.board[0][0] = 'x'
      @board.board[0][1] = 'x'
      @board.win_in_row_or_col?(@board.board).should be_false
    end

    it "should return false if the row is full but not a win" do
      @board.board[0][0] = 'x'
      @board.board[0][1] = 'x'
      @board.board[0][2] = 'o'
      @board.win_in_row_or_col?(@board.board).should be_false
    end
  end
  
  describe "win_in_row_or_col? col tests" do
    it "should return true if there is a win in the first col" do
      @board.board.each { |row| row[0] = 'x' }
      @board.win_in_row_or_col?(@board.board.transpose).should be_true
    end

    it "should return true if there is a win in the second col" do
      @board.board.each { |row| row[1] = 'x' }
      @board.win_in_row_or_col?(@board.board.transpose).should be_true
    end

    it "should return true if there is a win in the third col" do
      @board.board.each { |row| row[2] = 'x' }
      @board.win_in_row_or_col?(@board.board.transpose).should be_true
    end

    it "should return false if there is not a win" do
      @board.board[0][0] = 'x'
      @board.board[1][0] = 'x'
      @board.win_in_row_or_col?(@board.board.transpose).should be_false
    end

    it "should return false if the col is full but not a win" do
      @board.board[0][0] = 'x'
      @board.board[1][0] = 'x'
      @board.board[2][0] = 'o'
      @board.win_in_row_or_col?(@board.board.transpose).should be_false
    end
  end

  describe "win_in_left_diagonal? tests" do
    it "should return true if there is a win in the left diag" do
      (0..@board.size).each { |i| @board.board[i][i] = 'x' }
      @board.win_in_left_diagonal?.should be_true
    end

    it "should return false if there is 1 wrong player in the left diag" do
      @board.board[0][0] = 'x'
      @board.board[1][1] = nil
      @board.board[2][2] = 'x'
      @board.win_in_left_diagonal?.should be_false
    end

    it "should return false if there are 2 wrong players in the left diag" do
      @board.board[0][0] = 'x'
      @board.board[1][1] = nil
      @board.board[2][2] = 'o'
      @board.win_in_left_diagonal?.should be_false
    end
  end

  describe "win_in_right_diagonal? tests" do
    it "should return true if there is a win in the right diag" do
      (0..@board.size).each { |i| @board.board[i][@board.size - i] = 'x' }
      @board.win_in_right_diagonal?.should be_true
    end

    it "should return false if there is 1 wrong player in the right diag" do
      @board.board[0][2] = 'x'
      @board.board[1][1] = nil
      @board.board[2][0] = 'x'
      @board.win_in_right_diagonal?.should be_false
    end

    it "should return false if there are 2 wrong players in the right diag" do
      @board.board[0][2] = 'x'
      @board.board[1][1] = nil
      @board.board[2][0] = 'o'
      @board.win_in_right_diagonal?.should be_false
    end
  end

  describe "next_open_space tests" do
    it "should return false for a full board" do
      @board.board = Array.new(3) { Array.new(3) { 'x' } }
      @board.next_open_space.should be_false
    end

    it "should return the next open space" do
      @board.board[0][0] = 'x'
      row, col = @board.next_open_space
      row.should == 0
      col.should == 1
    end 

    it "should return the next open space" do
      @board.board[0] = ['x'] * 3
      row, col = @board.next_open_space
      row.should == 1
      col.should == 0
    end
  end

  describe "valid_input? tests" do
    it "should return false if row or col is not a number" do
      @board.valid_input?(0, 'x').should be_false
      @board.valid_input?('x', 0).should be_false
      @board.valid_input?('x', 'x').should be_false
    end

    it "should return false if row or col is too big" do
      @board.valid_input?(0, 3).should be_false
      @board.valid_input?(3, 0).should be_false
      @board.valid_input?(3, 3).should be_false
    end

    it "should return false if row or col is too small" do
      @board.valid_input?(0, -1).should be_false
      @board.valid_input?(-1, 0).should be_false
      @board.valid_input?(-1, -1).should be_false
    end

    it "should return true if the values are good" do
      (0..@board.size).each do |row|
        (0..@board.size).each do |col|
          @board.valid_input?(row, col).should be_true
        end
      end
    end
  end
end
