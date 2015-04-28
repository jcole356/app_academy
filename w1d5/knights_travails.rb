require './00_tree_node'

class KnightPathFinder < PolyTreeNode

  attr_reader :starting_pos

  POSSIBLE_MOVES = [[2, 1], [1, 2], [-2,-1], [-1, -2],
                    [-2, 1], [-1, 2], [2, -1], [1, -2]]

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @root_node = PolyTreeNode.new(starting_pos)
    @visited_positions = starting_pos
    build_move_tree
  end

  def build_move_tree
    @moves = []
    @moves << @root_node

    until @moves.empty?
      move = @moves.shift
      #return move if move.value == ENDINGPOSITION
      moves = new_move_positions(move.value)
      moves.each do |x|
        new_node = PolyTreeNode.new(x)
        new_node.parent = move
        @moves << new_node
      end
    end
  end

  def find_path(end_pos)
    [@starting_pos] + @root_node.bfs(end_pos).trace_back_path
  end

  def new_move_positions(pos)
    possible_moves = self.class.valid_moves(pos) - @visited_positions
    @visited_positions += possible_moves
    possible_moves
  end

  def self.valid_moves(pos)
    valid_moves = []
    POSSIBLE_MOVES.each do |x,y|
      move = [pos[0] + x, pos[1] + y]
      valid_moves << move if move[0] <= 7 && move[1] <= 7 && move[0] >= 0 &&
            move[1] >= 0
    end

    valid_moves
  end
end

kpf = KnightPathFinder.new([0,0])
p kpf.find_path([7,6])
#kpf.new_move_positions(kpf.starting_pos)
# p kpf.starting_pos
