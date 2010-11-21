require 'board'
require 'game_players'

class GameController
  attr_accessor :player_generator

  def initialize
    @board = Board.new
    @players = nil
  end

  def choose_game_type
    puts "Choose a game type"
    puts "Human Vs. Human (1)"
    puts "Computer Vs. Computer (2)"
    puts "Human Vs. Computer (3)"
    choice = gets.chomp.to_i
    return choice
  end

  def set_up_players(choice)
    case choice
    when 1
      player_list = [HumanPlayer.new('X', @board), HumanPlayer.new('O', @board)]
    when 2
      player_list = [ComputerPlayer.new('X', @board), ComputerPlayer.new('O', @board)]
    when 3
      player_list = [HumanPlayer.new('X', @board), ComputerPlayer.new('O', @board)]
    end

    @players = GamePlayers.new(player_list)
    @current_player = @players.next_player
  end

  def valid_choice(choice)
    return false if choice > 3 or choice < 1
    return true
  end

  def play_game
    puts banner

    choice = choose_game_type
    while not valid_choice(choice)
      choice = choose_game_type
    end

    set_up_players(choice)

    while not winner = @board.game_over?
      @board.print_board

      if @current_player.make_move
        @current_player = @players.next_player
      else
        puts "Invalid move, try again"
      end

      if @board.tie_game?
        @board.print_board
        puts "\nIt was a cats game"
        return
      end
    end

    @board.print_board
    puts ""
    puts "#{winner} was the winner"
  end

  def banner
    "Welcome to TicTacToe, good luck against the AI it's pretty tough :P"
  end
end
