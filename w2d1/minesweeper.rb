require 'byebug'


class Tile
  # @board = Board.new

  attr_accessor :tile_state
  def initialize(row, column, board, tile_state)
    @row = row
    @column = column
    @board = board
    @tile_state = tile_state

  end

  def bombed?
    return true if @board.bomb_areas.include?([@row, @column])
    return false
  end

  def flagged?
    return true if self.tile_state == "F"
    # return true
  end

  def revealed?
    return true if self.tile_state != "*"#.tile_state.is_a?(Integer)
  end

  def self.reveal(row, column)
    # self.title_state =
    #@board[row][column] = "_"
  end

  def self.neighbors(row, column)
    puts "DID IT GET HERE?"
    neighbors = [
      [row - 1, column - 1],
      [row - 1, column],
      [row - 1, column + 1],
      [row, column - 1],
      [row, column + 1],
      [row + 1, column - 1],
      [row + 1, column],
      [row + 1, column + 1]
    ]
    neighbors
  end


  def neighbor_bomb_count
    adjacent_bomb_count = 0
    squares = Tile.neighbors(@row, @column)

    squares.each do |neighbor|
      adjacent_bomb_count +=1 if @board.bomb_areas.include?(neighbor)
    end

    # @board.[](2, 2).tile_state = "-"

    if adjacent_bomb_count == 0
      # reveal fringe
        squares.each do |row, column|
          if row.between?(0, 8) && column.between?(0, 8)
            @board.[](row, column).tile_state = "_" unless @board.[](row, column).revealed?
          end
          #
          #
          #   @board.[](row, column).neighbor_bomb_count
          # end
        end
    end




    # end

    adjacent_bomb_count > 0 ? adjacent_bomb_count : "_"

    # return "this is not working"
  end

  def inspect
    tile_state
  end
end

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(9) { Array.new(9)}
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end


  def bomb_areas
    bomb_locations = []
    srand 87
    10.times do |bomb|
      row = rand(9)
      column = rand(9)
      bomb_locations << [row, column] if !bomb_locations.include?([row, column])
    end
    bomb_locations
  end

  def new_game
    # create our board with numbers and bombs
    #10 bombs

    @grid.each_with_index do |row, row_index|
      row.each_with_index do |square, column_index|
        tile_state = "*"
        @grid[row_index][column_index] = Tile.new(row_index, column_index, self, tile_state)
        # @grid[row_index][column_index] = "*"
      end
    end

  # p  @grid[0][0].flagged?



    # bomb_locations.each do |location|
    #   # square_row_name.set_bomb
    #   # @grid[location[0]][location[1]] #= "*"
    # end

    # # p bomb_locations
    # bomb_locations.each do |location|
    #   # p location[0]
    #   # p location[1]
    #   @grid[location[0]][location[1]] #= "*"
    # end

    # puts "WHY ARE YOU CALLING TWICE"

    # puts "what is returning here?"

  end

  def won?
    all_tiles = []
    @grid.each do |row|
      row.each do |tile|
        all_tiles << tile
      end
    end

    all_tiles.none? do |tile|
      tile.tile_state == "*"
    end


  end

  def play_game


    new_game

    loop do
      p bomb_areas



      puts "Select a square to flag or reveal.  e.g. 'F 1, 2' or 'R 1, 2'"

      user_selection = gets.chomp.delete(",").split(" ")

      row = user_selection[1].to_i
      column = user_selection[2].to_i
      if user_selection[0] == "F"
        @grid[row][column].tile_state = "F"# @grid[row][column].flagged?
      elsif user_selection[0] == "R"

        if @grid[row][column].flagged?
          puts "Choose another tile.  You have already flagged this space."
        else
          if @grid[row][column].bombed?#bomb_areas.include?([row, column])
            puts "You lose! This is a bomb."
          else #tile is not a bomb
            # byebug

            @grid[row][column].tile_state = @grid[row][column].neighbor_bomb_count
          end
        end
      end


      print_board
      if won?
        puts "You WON!"
        break
      end
    end


  end

  def print_board
    @grid.each do |row|
      row.map do |instance|
        instance = instance.tile_state
      end
      p row
    end

    #
    # # 9.times do |n|
    #   9.times { |i| p @grid[1][i] }
    # # end

  end
end
#
game1 = Board.new
# # game1.print_board
# # game1.new_game
# # p game1.grid
game1.play_game
