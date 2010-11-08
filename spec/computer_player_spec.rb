require File.dirname(__FILE__) + '/spec_helper'

describe "computer player tests" do
  before(:each) do
    @player = ComputerPlayer.new('x')
  end

  describe "open? tests" do
    it "should return 1 for a list of nil" do
      @player.open?([nil, nil, nil]).should == 1
    end
    
    it "should return 1 for a list with only x and nil in it" do
      @player.open?([nil, 'x', nil]).should == 1
    end

    it "should be 0 for a list with o in it" do
      @player.open?([nil, 'o', 'x']).should == 0
    end

    it "should return 0 for a list with only o in it" do
      @player.open?(['o'] * 3).should == 0
    end
  end

  describe "available_wins_heuristic tests" do
    it "should return 4 for an empty board and the center square" do
      @player.available_wins_heuristic(1,1).should == 4
    end
  end
end
