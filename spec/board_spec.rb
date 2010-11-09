require File.dirname(__FILE__) + '/spec_helper'

describe "board tests" do
  before(:each) do
    @board = Board.new
  end

  describe "initialization tests" do
    it "should create a blank board" do
      @board.board.should == Array.new(9) { nil }
    end
  end

  describe "valid_input tests" do
    it "should return true for valid input" do
      (0..8).each { |pos| @board.valid_input(pos).should be_true }
    end

    it "should reject anything bigger than the board array" do
      @board.valid_input(9).should be_false
    end

    it "should reject a negative space" do
      @board.valid_input(-1).should be_false
    end
  end

  describe "make_move tests" do
    it "should make a valid move" do
      @board[1].should be_nil
      @board.make_move(1, 'X')
      @board[1].should == 'X'
    end

    it "should reject an already taken space" do
      @board.make_move(1, 'X')
      @board.make_move(1, 'X').should be_false
    end

    it "should reject an invalid position" do
      @board.make_move('a', 'X').should be_false
    end
  end

  describe "open_space tests" do
    it "should return true for an empty space" do
      @board.open_space(0).should be_true
    end

    it "should return false for a take space" do
      @board.make_move(0, 'X')
      @board.open_space(0).should be false
    end
  end

  describe "open_moves tests" do
    it "should return 0 through 8 for an empty board" do
      @board.open_moves.should == [0,1,2,3,4,5,6,7,8]
    end

    it "should return 1 through if space 0 is taken" do
      @board.make_move(0, 'X')
      @board.open_moves.should == [1,2,3,4,5,6,7,8]
    end

    it "should return the open moves after 2 moves are made" do
      @board.make_move(1, 'X')
      @board.make_move(4, 'X')
      @board.open_moves.should == [0,2,3,5,6,7,8]
    end

    it "should return an empty array if there are no open moves" do
      (0..8).each { |pos| @board.make_move(pos, 'X') }
      @board.open_moves.should == []
    end
  end

  describe "win_in_set tests" do
    it "should return true for all X" do
      @board.make_move(0, 'X')
      @board.make_move(1, 'X')
      @board.make_move(2, 'X')
      @board.win_in_set([0, 1, 2]).should be_true
    end

    it "should return false for only 2 X" do
      @board.make_move(0, 'X')
      @board.make_move(1, 'X')
      @board.win_in_set([0, 1, 2]).should be_false
    end

    it "should return false for all nil" do
      @board.win_in_set([0, 1, 2]).should be_false
    end

    it "should return false for a mix of X and O" do
      @board.make_move(0, 'X')
      @board.make_move(1, 'O')
      @board.make_move(2, 'X')
      @board.win_in_set([0, 1, 2]).should be_false
    end
  end

  describe "game_over? tests" do
    it "should return true for a win in a row" do
      board = ['X', 'X', 'X', nil, nil, nil, nil, nil, nil] 
      board = Board.new(board)
      board.game_over?.should == 'X'
    end

    it "should return true for a win in a row" do
      board = [nil, nil, nil, nil, nil, nil, 'X', 'X', 'X'] 
      board = Board.new(board)
      board.game_over?.should == 'X'
    end

    it "should return true for a win in a col" do
      board = ['X', nil, nil, 'X', nil, nil, 'X', nil, nil] 
      board = Board.new(board)
      board.game_over?.should == 'X'    
    end

    it "should return true for a win in the left diagonal" do
      board = ['X', nil, nil, nil, 'X', nil, nil, nil, 'X'] 
      board = Board.new(board)
      board.game_over?.should == 'X'          
    end

    it "should return true for a win in the right diagonal" do
      board = [nil, nil, 'X', nil, 'X', nil, 'X', nil, nil] 
      board = Board.new(board)
      board.game_over?.should == 'X'
    end

    it "should return false if there is no win" do
      @board.game_over?.should be_false
    end
  end
end
