require File.dirname(__FILE__) + '/spec_helper'

describe "computer player tests" do
  before(:each) do
    @board = Board.new
    @player = ComputerPlayer.new('x', @board)
  end

  describe "toggle_symbol tests" do
    it "should return O for X" do
      @player.toggle_symbol('X').should == 'O'
    end

    it "should return X for O" do
      @player.toggle_symbol('O').should == 'X'
    end
  end
end
