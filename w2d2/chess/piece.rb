class Piece
  def initialize(options)
    @color = options[:color]
    @position = options[:position] # = []
    @moved = options[:moved]  # boolean
    @board = options[:board]
  end
  #
  # def symbol
  #   raise "Not implemented yet"
  # end

  def valid_moves
    # positions
    # checks if on board
    # checks if hitting own piece
    ## not entering check puts you in check
  end

end
