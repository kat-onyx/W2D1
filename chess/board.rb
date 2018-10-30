require_relative 'piece.rb'
require 'byebug'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) {Array.new(8)}
  end

  WHITE_START_PIECES = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]
  BLACK_START_PIECES = [Rook.new, Knight.new, Bishop.new, King.new, Queen.new, Bishop.new, Knight.new, Rook.new]

  def populate_board
    # debugger
    @board.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        case row_idx
        when 0
          @board[row_idx][col_idx] = WHITE_START_PIECES[col_idx]
        when 1
          @board[row_idx][col_idx] = Pawn.new
        when 6
          @board[row_idx][col_idx] = Pawn.new
        when 7
          @board[row_idx][col_idx] = BLACK_START_PIECES[col_idx]
        else
          @board[row_idx][col_idx] = NullPiece.new
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    startx, starty = start_pos
    stopx, stopy = end_pos
    raise InvalidStartPosError if @board[startx][starty].is_a? NullPiece
    raise InvalidEndPosError unless valid_move?(end_pos)
  end

  def valid_move?(pos)
    x,y = pos
    return false if (x > 7 || x < 0) || (y > 7 || y < 0)
    true
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @board[x][y] = val
  end

end
