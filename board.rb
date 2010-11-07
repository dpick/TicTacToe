require 'pp'

class Board
  attr_accessor :board, :size

  def initialize(size)
    @board = Array.new(size) { Array.new(size) { nil } }
    @size = size - 1
  end

  @@instance = Board.new(3)

  def self.instance
    return @@instance
  end

  def open_space?(row, col)
    @board[row][col].nil?
  end

  def make_move!(row, col, player)
    return @board[row][col] = player if open_space?(row, col)

    return false
  end

  def game_over?
    return true if win_in_rows?
    return true if win_in_cols?
    return true if win_in_left_diagonal?
    return true if win_in_right_diagonal?
    return false
  end

  def win_in_rows?
    return win_in_row_or_col?(@board)
  end

  def win_in_cols?
    return win_in_row_or_col?(@board.transpose)
  end

  def win_in_row_or_col?(board)
    result = nil
    board.each { |set| result ||= check_win_position(set) }

    return result
  end

  def win_in_left_diagonal?
    return check_win_position((0..@size).map { |i| @board[i][i] }) 
  end

  def win_in_right_diagonal?
    return check_win_position((0..@size).map { |i| @board[i][@size - i] }) 
  end

  def check_win_position(win_list)
    return win_list[0] if win_list.uniq.size == 1 and not win_list[0].nil?

    return false
  end

  def print_board
   puts "    0 | 1 | 2 " 
    (0..@size).each do |row|
      print "#{row}"
      (0..@size).each do |col|
        if not @board[row][col].nil?
          print " | #{@board[row][col]}" 
        else
          print " | -"
        end
      end
      puts ""
    end
  end

end
