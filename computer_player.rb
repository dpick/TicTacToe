require 'player'
require 'pp'

class ComputerPlayer < Player

  def initalize(symbol)
    super(symbol) 
  end

  def choose_move(board)
    newBoard = negamax(board, 1, @symbol) 

    while newBoard[:board].previous_board.board != board.board
      newBoard[:board] = newBoard[:board].previous_board
    end

    return {:row => newBoard[:board].move.first[0], :col => newBoard[:board].move.first[1]}
  end

  def opponent(sym)
    sym == @symbol ? 'X' : @symbol
  end

  def negamax(board, sign, sym)
    if @symbol == board.game_over? or board.full?
      return {:value => board.value(@symbol) * sign,
              :board => board}
    end

    max = {:value => -1000, :board => board}

    board.possible_moves.each do |row, col|
      valid, newBoard = board.make_move(row, col, sym)

      temp = negamax(newBoard, sign * -1, opponent(sym))
      max = temp if temp[:value] > max[:value]
    end

    return max
  end
end
