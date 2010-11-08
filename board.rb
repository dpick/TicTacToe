require 'pp'

class Board
  attr_accessor :board, :size, :previous_board, :move

  def initialize(size = 3, board = Array.new(size) { Array.new(size) { nil } }, prev = nil)
    @board = board     
    @size = size - 1
    @previous_board = prev
    @move = []
  end

  def value(sym)
    return 1 if game_over?
    return 0 if full?
  end

  def possible_moves
    possible_moves = []
    (0..@size).each do |row|
      (0..@size).each do |col|
        possible_moves << [row, col] if @board[row][col].nil?
      end
    end

    return possible_moves
  end

  def open_space?(row, col)
    @board[row][col].nil?
  end

  def make_move(row, col, player)
    return false, self if not valid_input?(row, col)
    if open_space?(row, col)
      newBoard = clone_board
      newBoard[row][col] = player
      newBoard = Board.new(@size + 1, newBoard, self)
      newBoard.move << [row, col, player]

      return true, newBoard
    end

    return false, self
  end

  def clone_board
    newBoard = []
    @board.each do |row|
      tempRow = []
      row.each do |col|
        tempRow << col
      end
      newBoard << tempRow
    end
    return newBoard
  end

  def valid_input?(row, col)
    return false if row.class != Fixnum || col.class != Fixnum
    return false if row > @size || col > @size
    return false if row < 0 || col < 0
    return true
  end

  def game_over?
    result = nil
    result ||= win_in_rows?
    result ||= win_in_cols?
    result ||= win_in_left_diagonal?
    result ||= win_in_right_diagonal?

    return result
  end

  def full?
    @board.flatten.compact.size == (@size + 1) * (@size + 1)
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

  def next_open_space
    @board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        return i, j if col.nil? 
      end
    end

    return false
  end

  def print_board
    puts "    0 | 1 | 2 " 
    puts "-" * 14
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
