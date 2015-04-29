require 'byebug'
require_relative 'piece_requirements'

class Board

  KLASSES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    seed_board
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def seed_board
    #seed pawns
    [1,6].each do |row|
      8.times do |col|
        color = (row == 1) ? :black : :white
        options = { color: color, position: [row, col],
                    board: self, moved: false }
        @grid[row][col] = Pawn.new(options)
      end
    end
    #seed others
    [0,7].each do |row|
      KLASSES.each.with_index do |klass, col|
        color = (row == 0) ? :black : :white
        options = { color: color, position: [row, col],
                    board: self, moved: false }
        @grid[row][col] = klass.new(options)
      end
    end
  end

  def self.deep_dup

  end

  def on_board?(position)
    row, col = position
    row.between?(0,7) && col.between?(0,7)
  end

  def occupied?(position)
    !piece_at(position).nil?
  end

  def piece_at(position)
    row, col = position
    @grid[row][col]
  end

  def checkmate?(color)

  end

  def check?(color)

  end



end



board = Board.new
p board[[1,1]].moves
