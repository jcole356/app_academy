def maze_solver(maze)
  maze_rows = []
  f = File.open(maze, "r")
  f.each_line do |line|
    maze_rows << line.chomp.split("")
  end
  p maze_rows
end

maze_solver(ARGV[0])
