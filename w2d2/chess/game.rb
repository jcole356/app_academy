require_relative 'board.rb'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @players = {
      white: HumanPlayer.new(:white),
      black: HumanPlayer.new(:black)
    }
    @current_player = :white
  end

  def play
    puts "Welcome to chess!"
    until @board.checkmate?(@current_player)
      # @board.render
      @players[@current_player].play_turn(board)
      @current_player = (@current_player == :white) ? :black : :white
    end
  end
end

class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(board)

    board.render

    begin
      puts "#{color.capitalize}'s turn. Input starting position as '0,0'"

      start_pos = gets.chomp.split(",").map { |n| n.to_i - 1 }

      puts "Input ending position as '0,0'"

      end_pos   = gets.chomp.split(",").map { |n| n.to_i - 1 }

      row, col = start_pos

      piece = board.grid[row][col]
      piece.move(board, end_pos) #unless piece.nil?
    rescue InvalidMoveError
      puts "Invalid move, try again!"
      retry
    end
  end
end

Game.new.play
