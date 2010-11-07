require File.dirname(__FILE__) + '/spec_helper'

describe "board tests" do
  before(:each) do
    @board = Board.new(3)
  end

  describe "initialization tests" do
    it "should make a board of size 3" do
      @board.size.should == 3
    end

    it "should have an empty board" do
      @board.board.should == Array.new(3) { Array.new(3) { nil } }
    end
  end

  describe "open_space? tests" do
    it "should be true for all spaces after initialization" do
      (0..@board.size - 1).each do |i|
        (0..@board.size - 1).each do |j|
          @board.open_space?(i, j).should be_true
        end
      end
    end

    it "should be false if a space isn't nil" do
      @board.board[0][0] = 'x'
      @board.open_space?(0, 0).should be_false
    end
  end

  describe "make_move! tests" do
    it "should make a move if the space is open" do
      @board.make_move!(0, 0, 'x')
      @board.board[0][0].should == 'x'
    end

    it "should return false if a space is taken" do
      @board.board[0][0] = 'x'
      @board.make_move!(0, 0, 'x').should be_false
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
      (0..@board.size - 1).each { |i| @board.board[i][i] = 'x' }
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
      (0..@board.size - 1).each { |i| @board.board[i][@board.size - 1 - i] = 'x' }
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
end
