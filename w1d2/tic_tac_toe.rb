class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def won?
    grid.each do |row|
      return true if row.all?
    end

    grid.transpose.each do |col|
      return true if col.all?
    end

    return true if [grid[0][0], grid[1][1], grid[2][2]].all?
    return true if [grid[0][2], grid[1][1], grid[2][0]].all?

    false
  end

  def empty?(pos)
    grid[pos[0]][pos[1]] == nil
  end

  def place_mark(pos,mark)
    grid[pos[0]][pos[1]] = mark
  end

  def render
    grid.each { |row| p row }
  end

  def winner
    #if active
  end
end

class Game

  attr_reader :player1, :player2

  attr_accessor :grid, :active_player

  def initialize#(player1, player2)
    @player1 = Player.new(:x)
    @player2 = Player.new(:o)
    @active_player = nil
    @grid = Board.new
  end

  def change_player(turn)
    if turn.odd?
      active_player = player1
    else
      active_player = player2
    end
  end

  def play
    turn = 1
    while true
      change_player(turn)
      grid.render
      pos = []
      puts "Enter a desired position on the board (row)"
      pos << Integer(gets)

      puts "Enter a desired position on the board (col)"
      pos << Integer(gets)

      if grid.empty?(pos)
        grid.place_mark(pos, active_player.mark)
        break if grid.won?
        #  break
        #end
        turn += 1
      else
        puts "Position is taken! Try again!"
      end
    end
  end

end

class Player

  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

end

class HumanPlayer < Player
end

class ComputerPlayer < Player
end
