Dir["*player.rb"].each { |file| require file }
require 'generator'

class GamePlayers
  def initialize
    @players_list = Array.new
    @players_list << HumanPlayer.new('X')
    @players_list << HumanPlayer.new('O')
    @players = player_generator
  end

  def next_player
    @players.next
  end

  def player_generator
    Generator.new do |g|
      while true:
        @players_list.each do |player|
          g.yield player
        end
      end
    end
  end
end
