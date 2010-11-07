class HumanPlayer < Player
  def choose_move
    puts "Enter a space to move (Row, Col)"
    move = gets.chomp
    move = move.gsub(/ /, '').split(",")

    return {:row => move[0], :col => move[1]}
  end
end
