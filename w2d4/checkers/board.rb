
class Board

  attr_reader :grid, :board

  def initialize(seed = true)
    @grid = Array.new(8) { Array.new(8) }
    seed_board unless seed == false
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    # puts "Print #{value}"
    @grid[x][y] = value
  end

  # This works, but it's much easier to use the flatten.compact
  # methods to address the nil spaces.
  def dup_board
    new_board = Board.new(false)
    self.grid.each_with_index do |row, i|
      row.each_with_index do |object, j|
        pos = [i, j]
        if object.nil?
          new_board[pos] = nil
        else
          new_board[pos] = Piece.new(object.color, pos, new_board)
        end
      end
    end

    new_board
  end

  def piece_at_position(pos)
    self[pos].nil? ? nil : self[pos]
  end

  def render
    self.grid.each do |row|
      display_line = []
      row.each do |space|
        display_line << space.color[0].upcase if space.is_a?(Piece)
        display_line << "_" if space.nil?
      end

      puts display_line.join("|")
    end
  end

  def seed_board
    8.times do |row|
      next if row.between?(3, 4)
      color = row.between?(0, 2) ? :red : :black
      8.times do |i|
        if row.even?
          next if i.even?
          self[[row, i]] = Piece.new(color, [row, i], self)
        else
          next if i.odd?
          self[[row, i]] = Piece.new(color, [row, i], self)
        end
      end
    end
  end
end

# board = Board.new
# board.seed_board
# p board.render
#
# board.seed_board
# board.render
#
# p board.occupied?([0, 1])
# p board.occupied?([0, 0])
