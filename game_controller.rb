require 'board'
require 'game_players'

class GameController
  attr_accessor :player_generator
  
  def initialize
    @board = Board.instance
    @players = GamePlayers.new
    @current_player = @players.next_player
  end

  def play_game
    puts banner
    while not winner = @board.game_over?
      @board.print_board

      if @current_player.make_move 
        @current_player = @players.next_player
      else
        puts "Invalid move, try again"
      end
    end

    @board.print_board
    puts ""
    puts "#{winner} was the winner"
  end

  def banner
    "Welcome to TicTacToe, good luck against the AI it's pretty tough :P"
  end

  def player_generator

  end

end
