require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
  attr_reader :board

  def initialize(board = Board.new)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    system("clear")
    puts @cursor.cursor_pos
    @board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        if @cursor.cursor_pos == [row_idx, col_idx]
          print " #{piece.inspect} ".colorize(:color => piece.color, :background => :cyan)
        elsif (row_idx + col_idx) % 2 == 1
          print " #{piece.inspect} ".colorize(:color => piece.color, :background => :red)
        elsif (row_idx + col_idx) % 2 == 0
          print " #{piece.inspect} ".colorize(:color => piece.color, :background => :yellow)
        end
      end
      print "\n"
    end
  end

  def cursor_test
    10.times do
      render
      @cursor.get_input
    end
  end
end
