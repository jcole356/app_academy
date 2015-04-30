require 'byebug'


# This needs a major overhaul to remove the need to pass coordinates
# to all of these methods all the time.

class Tile

  attr_accessor :tile_state

  def initialize(row, column, board, tile_state)
    @row = row
    @column = column
    @board = board
    @tile_state = tile_state
  end

  def adjacent_bomb_count
    adjacent_bomb_count = 0
    neighboring_tiles = neighbors(@row, @column)

    neighboring_tiles.each do |neighbor|
      adjacent_bomb_count +=1 if @board.bomb_locations.include?(neighbor)
    end
  end

  def bombed?
    return true if @board.bomb_locations.include?([@row, @column])
    false
  end

  def toggle_flag
    if tile_state == "*"
      @tile_state = "F"
    else
      @tile_state = "*"
    end
  end

  def flagged?
    return true if @tile_state == "F"
    false
  end

  def revealed?
    return true if (@tile_state == "_" || @tile_state.is_a?(Fixnum))
  end

  def reveal #Intended to reveal all tiles at end of game

  end

  def neighbors(row, column)
    # puts "DID IT GET HERE?"
    neighbors = [
                [row - 1, column - 1],
                [row - 1, column    ],
                [row - 1, column + 1],
                [row,     column - 1],
                [row,     column + 1],
                [row + 1, column - 1],
                [row + 1, column    ],
                [row + 1, column + 1]
                ]
    neighbors
  end


  def neighbor_bomb_count

    if adjacent_bomb_count == 0
      neighboring_tiles.each do |row, column|
        if @board.valid_space?([row, column]) &&
           !@board.[](row, column).revealed? &&
           !@board.[](row, column).bombed?

          @board.[](row, column).tile_state = "_"
          @board.[](row, column).neighbor_bomb_count
        end
      end
    end

    adjacent_bomb_count > 0 ? adjacent_bomb_count : "_"
  end

  def inspect
    tile_state
  end
end

class Board

  attr_reader :grid, :bomb_locations

  def initialize
    @grid = Array.new(9) { Array.new(9)}
    @bomb_locations = place_bombs
    seed_board
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end


  def place_bombs
    bomb_locations = []

    10.times do |bomb|
      row = rand(9)
      column = rand(9)
      unless bomb_locations.include?([row, column])
        bomb_locations << [row, column]
      end
    end

    bomb_locations
  end

  def play_game


    # debugger

    until won?

      user_input    = user_selection
      position      = user_input[:position]
      row, column   = position

      p @bomb_locations #This is for debugging purposes only


      if user_input[:tile_action] == "F"
        @grid[row][column].toggle_flag
      elsif user_input[:tile_action] == "R"
        if @grid[row][column].flagged?
          puts "Choose another tile. You have flagged this space."
        elsif @grid[row][column].bombed?
          puts "You lose! This is a bomb."
          reveal
        else #tile is not a bomb
          @grid[row][column].tile_state = @grid[row][column].neighbor_bomb_count
        end
      end


      # render

      if won?
        puts "You WON!"
        break
      end
    end


  end

  def user_selection
    render

    valid = false

    until valid
      puts "Select a square to flag or reveal.  e.g. 'F12' or 'R12'"

      user_selection = gets.chomp.split("")

      p user_selection

      tile_action = user_selection[0].upcase
      row         = user_selection[1].to_i
      column      = user_selection[2].to_i
      position    = [row, column]

      valid = true if valid_space?(position)
    end

    {tile_action:tile_action, position:position}

  end

  def valid_space?(position)
    row, column = position
    row.between?(0, 8) && column.between?(0, 8)
  end

  def seed_board
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |square, column_index|
        tile_state = "*"
        @grid[row_index][column_index] = Tile.new(row_index, column_index, self, tile_state)
      end
    end
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


  def render
    @grid.each do |row|
      row.map do |instance|
        instance = instance.tile_state
      end
      p row
    end
  end

end
#
game1 = Board.new
# # game1.print_board
# # game1.new_game
# # p game1.grid
game1.play_game
