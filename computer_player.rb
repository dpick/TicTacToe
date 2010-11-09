require 'player'

class ComputerPlayer < Player

  def initalize(symbol)
    super(symbol) 
  end

  def choose_move
    best = -10
    best_move = -1
    
    Board.instance.open_moves.each do |possible_move|
      Board.instance.make_move(possible_move, @symbol)
      val = -negamax(toggle_symbol(@symbol))
      Board.instance.reset_move(possible_move)
      if val > best
        best = val
        best_move = possible_move
      end
    end

    return best_move
  end

  def negamax(sym)
    winner = Board.instance.game_over?
    return 1 if winner == sym
    return -1 if winner == toggle_symbol(sym)

    best = -1000

    Board.instance.open_moves.each do |move|
      Board.instance.make_move(move, sym)
      value = -negamax(toggle_symbol(sym))
      Board.instance.reset_move(move)
      best = value if value > best
    end

    return 0 if best == -1000
    return best
  end

  def toggle_symbol(sym)
    sym == 'O' ? 'X' : 'O'
  end
end
