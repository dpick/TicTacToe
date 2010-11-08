class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def make_move
    move = choose_move
    Board.instance.make_move!(move[:row], move[:col], @symbol)
  end

  def choose_move
    row, col = Board.instance.board.next_open_space
    return {:row => row, :col => col}
  end
end
