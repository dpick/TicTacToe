class Player
  attr_accessor :symbol

  def initialize(symbol, board)
    @symbol = symbol
    @board = board
  end

  def make_move
    @board.make_move(choose_move, @symbol)
  end

  def choose_move
  end
end
