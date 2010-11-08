class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def make_move(board)
    move = choose_move(board)
    board.make_move(move[:row], move[:col], @symbol)
  end

  def choose_move(board)
    row, col = board.next_open_space
    return {:row => row, :col => col}
  end
end
