require File.dirname(__FILE__) + '/spec_helper'

describe "game_players tests" do
  before(:each) do
    @board = Board.new
    @game_players = GamePlayers.new(@board, [HumanPlayer.new('X', @board), ComputerPlayer.new('O', @board)])
  end

  it "should return player X first" do
    @game_players.next_player.symbol.should == 'X'
  end

  it "should return player X, then O" do
    @game_players.next_player.symbol.should == 'X'
    @game_players.next_player.symbol.should == 'O'
  end

  it "should return X, then O, then X" do
    @game_players.next_player.symbol.should == 'X'
    @game_players.next_player.symbol.should == 'O'
    @game_players.next_player.symbol.should == 'X'
  end
end
