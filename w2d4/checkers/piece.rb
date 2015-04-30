require 'byebug'

class Piece

  MOVES = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  # JUMPING_MOVES = [[]]

  attr_reader :color, :position
  # May not want this after finished with debugging
  attr_accessor :king

  def initialize(color, position)
    @color = color
    @king = false
    @position = position
  end

  def move_diffs
    # The logic for determining the pieces direction should belong here
  end

  def maybe_promote

  end

  def perform_jump(pos)
    jumping_moves = MOVES.map { |x, y| [(x * 2), (y * 2)] }

    jumping_moves.select { |x, y| x.between?(0, 7) && y.between?(0, 7)}

  end

  def perform_slide(pos)
    if @king && valid_moves_king.include?(pos)
      @position = pos
    else
      raise "Not a valid move!"
    end

    nil
  end

  def valid_moves
    x, y = @position
    direction = @color == :red ? 1 : -1

    if @king == false
      valid_moves = MOVES[0..1].map do |dx, dy|
        [(dx * direction) + x, (dy * direction) + y]
      end
    end

    valid_moves.select { |x, y| x.between?(0, 7) && y.between?(0, 7)}
  end

  def valid_moves_king
    x, y = @position

    if @king == true
      valid_moves = MOVES.map do |dx, dy|
        [dx + x, dy + y]
      end
    end

    valid_moves.select { |x, y| x.between?(0, 7) && y.between?(0, 7)}
  end

end

# red   = Piece.new(:red, [0,1])
# black = Piece.new(:black, [7,0])
#
# # p red.color
# # p red.position
# # puts "Valid moves"
# # p red.valid_moves
# # p black.color
# # p black.position
# # puts "Valid moves"
# # p black.valid_moves
#
# p red.color
# red.king = true
# p red.position
# puts "New position"
# red.perform_slide([1, 0])
# p red.position
# puts
# p black.color
# black.king = true
# p black.position
# puts "New position"
# black.perform_slide([6, 1])
# p black.position
