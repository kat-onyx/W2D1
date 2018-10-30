module SlidingPiece
  def moves(start_pos, board)
    xstart, ystart = start_pos
    possible_moves = []
    8.times do |idx|
      possible_moves << [xstart, idx]
      possible_moves << [idx, ystart]
    end

    possible_moves.reject! { |move| move ==  start_pos }
  end
end

module SteppingPiece
  def moves(start_pos, board) #returns list of valid possible moves
    xstart, ystart = start_pos
    possible_moves = []
    @shifts.each do |shift|
      x_shift, y_shift = shift
      possible_moves << [xstart + x_shift, ystart + y_shift]
    end
    possible_moves.select! {|move| board.valid_pos?(move) && board.valid_destination?(start_pos, move)}
    return possible_moves
  end
end

class Piece
  attr_reader :color, :shifts

  def initialize(color)
    @color = color
  end

  def inspect
    piece_name = self.class.name
    case piece_name
    when "Rook"
      "R"
    when "Knight"
      "N"
    when "Bishop"
      "B"
    when "King"
      "K"
    when "Queen"
      "Q"
    when "Pawn"
      "P"
    when "NullPiece"
      " "
    end
  end
end

class Rook < Piece
end

class Knight < Piece
  include SteppingPiece
  def initialize(color)
    @shifts = [[-2,-1], [-1,-2], [1,-2], [2,-1], [-2,1], [-1,2], [1,2], [2,1]]
    super
  end

end

class Bishop < Piece
end

class King < Piece
  def initialize(color)
    @shifts = [[1,0],[1,1],[0,1],[-1,0],[-1,1],[-1,-1],[0,-1],[1,-1]]
    super
  end
  include SteppingPiece
end

class Queen < Piece
end

class Pawn < Piece
end

require 'singleton'

class NullPiece < Piece
  include Singleton
  def initialize
    @color = nil
  end
end
