class PolyTreeNode

  # attr_reader :value, :children
  #attr_accessor :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def add_child(child)
    child.parent=(self)
  end

  def bfs(target_value)
    queue = []
    queue << self

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each do |child|
        queue << child
      end
    end

    nil
  end

  def children
    @children
  end

  def dfs(target_value)
    return self if @value == target_value

    found = nil
    @children.each do |child|
      found = child.dfs(target_value)
      return found if found
    end

    found
  end

  def parent
    @parent
  end

  def parent=(parent_node)
    if @parent == nil
      @parent = parent_node
      parent_node.children << self unless parent_node == nil ||
              parent_node.children.include?(self)
    else
      @parent.children.delete(self)
      @parent = parent_node
      parent_node.children << self unless parent_node == nil ||
              parent_node.children.include?(self)
    end
  end

  def remove_child(child)
    if !@children.include?(child)
      raise "Error: Child does not exist"
    else
      @children.delete(child)
      child.parent = nil
    end
  end

  def trace_back_path
    final_array = []
    start = self
    until start.parent == nil
      final_array << start.value
      start = start.parent
    end

    #p final_array
    final_array.reverse
  end

  def value
    @value
  end

end
