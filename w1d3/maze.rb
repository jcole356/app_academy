require 'byebug'

class Maze
  def initialize(filename)
    @maze = File.readlines(filename).map{|line| line.chomp.split("")}
    @solver = Solver.new(@maze)
  end


end

class Solver
  def initialize(maze)
    solve(findStart(maze),maze)
  end



  def findStart(maze)
    maze.each_with_index do |v,y|
      v.each_with_index do |c,x|
        if(c == 'S')
          return [y,x]
        end
      end
    end

    [0,0]
  end

  def solve(pos,maze)
    byebug
    x = pos[1]
    y = pos[0]


    if maze[y][x] == "E"
      puts "You have reached the end of the maze!"
      return
    elsif maze[y][x] == "*"
      return
    else
      mark_space(pos, maze)
      find_empty_space(pos, maze)
    end

  end

  def find_empty_space(pos, maze)
    x = pos[1]
    y = pos[0]

    if(x > 0)
      solve(pos[y,x - 1],maze)
    end

    if(y > 0)
      solve(pos[y-1,x],maze)
    end

    if(x < maze[y].length-1)
      solve(pos[y,x + 1],maze)
    end

    if(y < maze.length-1)
      solve(pos[y + 1,x1],maze)
    end

  end

  def mark_space(pos, maze)
    maze[pos[0]][pos[1]] = "X"
  end

end
