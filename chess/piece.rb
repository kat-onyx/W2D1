module SlidingPiece
  def moves(start_pos, board)
    xstart, ystart = start_pos

    position_arr = []
    row = xstart
    col = ystart
    until col > 7
      position_arr << [xstart, col] if ystart != col
      col += 1
    end

    generate_unblocked_moves(start_pos, position_arr, board)

    #
    # until x > 7
    #   position_arr << [x, ystart]
    #   x += 1
    # end
    #
    # until x < 0
    #   position_arr << [x, ystart]
    #   x -= 1
    # end
    #
    # until y < 0
    #   position_arr << [xstart, y]
    #   y -= 1
    # end


    # 8.times do |idx|
    #   possible_moves << [xstart, idx]
    #   possible_moves << [idx, ystart]
    # end
    #
    # possible_moves.reject! { |move| move ==  start_pos }

    # idx_arr = []


    # board.grid[xstart].each_with_index do |space, idx|
    #   until idx == ystart
    #     if space_has_piece?(xstart,idx)
    #       idx_arr << pos of piece if piece is not null
    #     end
    #   end
    #   if idx == ystart
    #     last_piece_on_left = idx_arr.last
    #     idx_arr = []
    #   end
    #   if idx > ystart
    #     idx_arr << pos of piece if piece is not null && idx_arr.empty? == false
    #   end
    # end
  end

  def generate_unblocked_moves(start_pos, position_arr, board)
    xstart, ystart = start_pos
    possible_moves = []

    position_arr.each do |position|
      x, y = position
      debugger
      piece_count = 0
      unless piece_count == 1
        if board.grid[x][y].is_a? NullPiece
          possible_moves << position
        elsif board.grid[x][y].color != board.grid[xstart][ystart].color
          possible_moves << position
          piece_count += 1
        end
      end
    end
    return possible_moves
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
  include SlidingPiece
end

class Knight < Piece
  include SteppingPiece
  def initialize(color)
    @shifts = [[-2,-1], [-1,-2], [1,-2], [2,-1], [-2,1], [-1,2], [1,2], [2,1]]
    super
  end

end

class Bishop < Piece
  include SlidingPiece
end

class King < Piece
  def initialize(color)
    @shifts = [[1,0],[1,1],[0,1],[-1,0],[-1,1],[-1,-1],[0,-1],[1,-1]]
    super
  end
  include SteppingPiece
end

class Queen < Piece
  include SlidingPiece
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
