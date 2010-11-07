class GameController
  
  def initialize
    @board = Board.instance
    @human_player = HumanPlayer.new('x')
    @AI_player = ComputerPlayer.new('o')
  end

end
