Dir["*player.rb"].each { |file| require file }
require 'generator'

class GamePlayers
  def initialize(player_list)
    @players_list = player_list
    @players = player_generator
  end

  def next_player
    @players.next
  end

  #probably could have used fibers here but didn't want to require ruby 1.9.2
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
