require_relative 'piece.rb'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    populate_board
  end

  WHITE_START_PIECES = [Rook.new(:white), Knight.new(:white), Bishop.new(:white), Queen.new(:white), King.new(:white), Bishop.new(:white), Knight.new(:white), Rook.new(:white)]
  BLACK_START_PIECES = [Rook.new(:black), Knight.new(:black), Bishop.new(:black), King.new(:black), Queen.new(:black), Bishop.new(:black), Knight.new(:black), Rook.new(:black)]

  def populate_board
    # debugger
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        case row_idx
        when 0
          @grid[row_idx][col_idx] = BLACK_START_PIECES[col_idx]
        when 1
          @grid[row_idx][col_idx] = King.new(:black)
        when 6
          @grid[row_idx][col_idx] = Pawn.new(:white)
        when 7
          @grid[row_idx][col_idx] = WHITE_START_PIECES[col_idx]
        else
          @grid[row_idx][col_idx] = NullPiece.instance
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    startx, starty = start_pos
    stopx, stopy = end_pos
    raise "No Piece At Start Position" if @grid[startx][starty].is_a? NullPiece
    raise "End Position Off Board" unless valid_pos?(end_pos)
    raise "End Position Has Allied Piece" unless valid_destination?(start_pos, end_pos)
    piece = @grid[startx][starty]
    possible_moves = piece.moves(start_pos, self)
    raise "Piece Does Not Move Like That" unless possible_moves.include?(end_pos)
    piece_moved = @grid[startx][starty]
    if valid_destination?(start_pos, end_pos) && possible_moves.include?(end_pos)
      @grid[stopx][stopy] = piece_moved
      @grid[startx][starty] = NullPiece.instance
    end
  end

  def valid_destination?(start_pos, end_pos)
    startx, starty = start_pos
    stopx, stopy = end_pos
    piece_moved = @grid[startx][starty]
    piece_at_end_pos = @grid[stopx][stopy]
    return false if piece_moved.color == piece_at_end_pos.color
    true
  end

  def valid_pos?(pos)
    x,y = pos
    return false if (x > 7 || x < 0) || (y > 7 || y < 0)
    true
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

end
