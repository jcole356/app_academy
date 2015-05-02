class Array
  def my_uniq
    uniques = []
    self.each { |el| uniques << el unless uniques.include?(el) }
    uniques
  end

  def two_sum
    indices = []
    (count - 1).times do |i|
      j = i + 1
      (count - 1 - i).times do
        indices << [i, j] if self[i] + self[j] == 0
        j += 1
      end
    end
    indices
  end

  def my_transpose
    dup = Array.new(length) { Array.new(length) }
    self.each_with_index do |row, i|
      row.each_with_index do |el, j|
        dup[i][j] = self[j][i]
      end
    end
    dup
  end
end

def stock_picker(something_else)
  best_pair = 0
  best_indices = nil

  i = 0
  while i < something_else.length - 1

    j = i + 1
    while j < stock_prices.length
      if something_else[j] - something_else[i] > best_pair
        best_pair = something_else[j] - something_else[i]
        best_indices = [i, j]
      end
      j += 1
    end

    i += 1
  end
  best_indices
end
