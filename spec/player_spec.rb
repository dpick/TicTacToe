require File.dirname(__FILE__) + '/spec_helper'
require 'player'

describe "player tests" do
  before(:each) do
     @player = Player.new('x')
  end

  describe "choose_move tests" do
    it "should return 0, 0 for an empty board" do
      @player.choose_move[:row].should == 0
      @player.choose_move[:col].should == 0
    end
  end
end
