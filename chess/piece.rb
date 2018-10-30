
class Piece
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
end

class Rook < Piece
end

class Knight < Piece
end

class Bishop < Piece
end

class King < Piece
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
