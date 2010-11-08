require 'player'

class HumanPlayer < Player
  def initalize(symbol)
    super(symbol) 
  end

  def choose_move
    puts "Enter a space to move (Row, Col)"
    move = gets.chomp
    move = move.gsub(/ /, '').split(",")

    return {:row => move[0].to_i, :col => move[1].to_i}
  end
end
