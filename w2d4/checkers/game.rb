require_relative 'board.rb'
require_relative 'piece.rb'


class Game

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:black)
    @player2 = HumanPlayer.new(:red)
    @current_player = @player1
  end

  def play
    won = false
    turn = 0

    until won
      @current_player = turn == 0 ? @player1 : @player2
      @board.render
      positions = @player1.accept_input


      turn += 1
    end


  end

end

class HumanPlayer

  def initialize(color)
    @color = color
  end

  def accept_input
    puts "#{@color.upcase}, it's your turn!  Select a spot to
          move from"

    start_pos = gets.chomp.split(",")

    puts "#{@color.upcase}, it's your turn!  Select a spot to
          move from"

    end_pos = gets.chomp.split(",")

    [start_pos, end_pos]
  end

end

new_game = Game.new
new_game.play
