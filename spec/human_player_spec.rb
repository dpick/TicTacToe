require File.dirname(__FILE__) + '/spec_helper'

describe "human player tests" do
  before(:each) do
    @player = HumanPlayer.new('x')
  end

  describe "choose_move tests" do
    it "should return a move that was entered" do
      @player.choose_move
    end
  end
end
