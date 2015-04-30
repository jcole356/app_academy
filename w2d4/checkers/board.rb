class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }


  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos)
    x, y = pos
    @grid[x, y] = @grid[x][y]
  end

  def dup_board

  end

  def render

  end

  def seed_board
    8.times do |row|
      next if row.between?(3, 4)
      color = row.between?(0, 3) ? :red : :black
      8.times do |i|
        if row.even?
          next if i.even?
          board[row, i] = Piece.new(color, [row, i])
        else
          next if i.odd?
          board[row, i] = Piece.new(color, [row, i])
        end
      end
    end

    nil
  end

end

board = Board.new

p board.[]([0, 1])
