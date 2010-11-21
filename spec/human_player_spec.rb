require File.dirname(__FILE__) + '/spec_helper'

describe "human player tests" do
  before(:each) do
    @board = Board.new
    @player = HumanPlayer.new('x', @board)
  end
end
