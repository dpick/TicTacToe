class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def make_move
    Board.instance.make_move(choose_move, @symbol)
  end

  def choose_move
  end
end
