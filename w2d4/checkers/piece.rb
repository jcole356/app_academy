class Piece

  MOVES = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

  attr_reader :color, :position

  attr_accessor :king, :position

  def initialize(color, position, board)
    @color = color
    @king = false
    @position = position
    @board = board
  end

  def move_diffs
    @color == :red ? 1 : -1
  end

  # This should be ok now
  def maybe_promote
    if @color == :black && @position[0] == 0
      @king = true
    elsif @color == :red && @position[0] == 7
      @king = true
    end
  end

  def perform_moves(move_sequence)
    if valid_move_sequence?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise "InvalidMoveError"
    end
  end

  def perform_moves!(move_sequence)
    if move_sequence.count == 1
      perform_slide(move_sequence[0])
    else
      move_sequence.each do |move|
        perform_jump(move)
      end
    end

    nil
  end

  def perform_jump(pos)
    x, y = pos
    old_pos = @position
    x_old, y_old = old_pos
    # Need to check for enemy.  This is hideous.  Need to improve.
    # Try just using an average.
    enemy_x, enemy_y = (x_old + ((x - x_old)/2)), (y_old + ((y - y_old)/2))
    # debugger
    if valid_jumps.include?(pos) &&
      @board.piece_at_position(pos).nil? &&
      !@board.piece_at_position([enemy_x, enemy_y]).nil?
      if @board.piece_at_position([enemy_x, enemy_y]).color != @color
        @position = pos
        @board[pos] = self
        @board[old_pos] = nil
        @board[[enemy_x, enemy_y]] = nil
      end
    else
      raise "Not a valid move!"
    end

    maybe_promote
  end

  def perform_slide(pos)
    old_pos = @position
    if valid_slides.include?(pos) && @board.piece_at_position(pos).nil?
      @position = pos
      @board[pos] = self
      @board[old_pos] = nil
    else
      raise "Not a valid move!"
    end

    maybe_promote
  end

  def valid_move_sequence?(move_sequence)
    new_board = @board.dup_board
    pos = self.position

    begin
      new_board[pos].perform_moves!(move_sequence).nil?
    rescue
      false
    else
      true
    end

  end

  def valid_slides
    x, y = @position
    direction = move_diffs
    if @king == false
      valid_slides = MOVES[0..1].map do |dx, dy|
        [(dx * direction) + x, (dy * direction) + y]
      end
    else
      valid_slides = MOVES.map do |dx, dy|
        [dx + x, dy + y]
      end
    end

    valid_slides.select do |x, y|
      x.between?(0, 7) && y.between?(0, 7)
    end
  end

  def valid_jumps
    x, y = @position
    direction = move_diffs
    if @king == false
      valid_jumps = MOVES[0..1].map do |dx, dy|
        [((dx * direction * 2) + x), ((dy * direction * 2) + y)]
      end
    else
      valid_jumps = MOVES.map do |dx, dy|
        [((dx * 2) + x), ((dy * 2) + y)]
      end
    end

    valid_jumps.select { |x, y| x.between?(0, 7) && y.between?(0, 7)}
  end

end

# board = Board.new(false)
# board = Board.new
# board.render
# puts
# new_board = board.dup_board
# new_board.render
# p board[[0,1]].object_id
# p new_board[[0,1]].object_id

# red1 = Piece.new(:red, [4, 4], board)
# red2 = Piece.new(:red, [3, 5], board)
# black = Piece.new(:black, [5, 2], board)
# board[[4, 3]] = red1
# board[[2, 5]] = red2
# board[[5, 2]] = black
# board.render
# puts
# black.perform_moves!([[4, 1]])


# p black.valid_move_sequence?([[3,4], [1, 6]])
# black.perform_moves([[3,4], [1, 6]])
# board.render
# puts
# board[[5, 2]].perform_jump([3, 4])
# board.render



# board[[2,1]].perform_slide([3, 0])
# board.render
# board[[2,1]].perform_slide([3, 0])
