class Board
  attr_accessor :board

  ROWS = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  COLS = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
  DIAGONALS = [[0, 4, 8], [2, 4, 6]]

  def initialize(board = [nil] * 9)
    @board = board
  end
  
  @@instance = Board.new

  def self.instance
    return @@instance
  end

  def [](position)
    @board[position]
  end

  def open_space(position)
    @board[position].nil? 
  end

  def reset_move(position)
    @board[position] = nil
  end

  def make_move(position, player)
    return false if not valid_input(position)
    return false if not open_space(position)
    @board[position] = player
  end

  def valid_input(position)
    return false unless position.class == Fixnum
    return false if position < 0 or position > @board.length - 1
    true
  end

  def game_over?
    ROWS.each { |row| return @board[row[0]] if win_in_set(row) }
    COLS.each { |col| return @board[col[0]] if win_in_set(col) }
    DIAGONALS.each { |diag| return @board[diag[0]] if win_in_set(diag) }

    return false
  end

  def win_in_set(set)
    value = @board[set[0]]
    set.each do |position|
      return false if @board[position] != value 
      return false if @board[position].nil?
    end

    return true
  end

  def open_moves
    (0..8).inject([]) do |open, position| 
      if @board[position].nil?
        open << position 
      else
        open
      end
    end
  end

  def print_board
    ROWS.each_with_index do |row, i|
      puts '- ' * 5 if (i == 1 or i == 2)
      temp = row.map { |i| @board[i] }
      temp.each_with_index { |sym, i| temp[i] = '*' if sym.nil? }
      puts temp.join(" | ")
    end

    puts ""
  end
end
