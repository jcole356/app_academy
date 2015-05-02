class Game
  attr_reader :towers

  def initialize
    @towers = [[1, 2, 3], [], []]
  end

  def render
    @towers
  end

  def move(pos1, pos2)
    raise "Invalid move" if @towers[pos1].empty?
    disk = @towers[pos1].shift
    if @towers[pos2].empty? || @towers[pos2].first > disk
      towers[pos2].unshift(disk)
    elsif disk > @towers[pos2].first
      raise "Invalid move"
    end
  end

  def won?
    @towers == [[], [], [1, 2, 3]]
  end
end
