def my_uniq(arr)
  result = []
  arr.each do |e|
    result << e unless result.include?(e)
  end

  result
end

class Array
  def my_uniq
    result = []
    self.each do |e|
      result << e unless result.include?(e)
    end

    result
  end
end

# p [1,1,3,3,4,4,5,3,1,65].my_uniq
# p [1,2,3,4,5].my_uniq
# p [1,2,1,3,3].my_uniq

class Array
  def two_sum
    result = []
    idx_1 = 0
    while idx_1 < self.length
      idx_2 = idx_1 + 1
      while idx_2 < self.length
        result << [idx_1, idx_2] if self[idx_1]+self[idx_2] == 0
        idx_2 += 1
      end
      idx_1 += 1
    end

    result
  end
end

# p [-1, 0, 2, -2, 1].two_sum

def my_transpose(matrix)
  result = []
  matrix.count.times do
    result << []
  end
  idx1 = 0
  while idx1 < matrix.count
    idx2 = 0
    while idx2 < matrix.count
      result[idx2][idx1] = matrix[idx1][idx2]
      idx2 += 1
    end
    idx1 += 1
  end
  result
end

# p my_transpose([[0, 1, 2],
#                [3, 4, 5],
#                [6, 7, 8]])

def stock_picker(prices)
  best_gain = 0
  best_days = []
  i = 0
  while i < prices.length - 1
    j = i+1
    while j < prices.length
      if (prices[j]-prices[i]) >= best_gain
        best_gain = (prices[j]-prices[i])
        best_days = [i, j]
      end
      j += 1
    end
    i += 1
  end

  best_days
end

# p stock_picker([10,3,6,7,5,10,1,3])

def towers_of_hanoi
  towers = [[4, 3, 2, 1],[],[]]

  until towers[1] == [4, 3, 2, 1] || towers[2] == [4, 3, 2, 1]
    p towers
    puts "Select tower from which to move disk (must be between 0 and 2):"
    t_from = gets.chomp.to_i
    puts "Select tower to which to move disk (must be between 0 and 2):"
    t_to = gets.chomp.to_i

    if towers[t_to].empty? || towers[t_to].last > towers[t_from].last
      towers[t_to] << towers[t_from].pop
    else
      puts "Nope!"
    end

  end
  puts "You win!!"

end

# towers_of_hanoi
