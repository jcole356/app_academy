class Array
  def my_each(&prc)
    i = 0
    while i < self.count
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_map(&prc)
    new_array = []
    self.my_each { |ele| new_array << prc.call(ele) }
    new_array
  end

  def my_select(&prc)
    new_array = []
    self.my_each do |ele|
      new_array << ele if prc.call(ele)
    end
    new_array
  end

  def my_inject(&prc)
    result = self.first
    self.drop(1).my_each { |ele| result = prc.call(result, ele) }
    result
  end

  def my_sort!(&block)
    return self if self.count <= 1

    pivot = self.first
    left, right = [], []
    self.drop(1).each do |ele|
      if block.call(pivot, ele) == -1 || block.call(pivot, ele) == 0
        right << ele
      elsif block.call(pivot, ele) == 1
        left << ele
      end
    end
    self[0...self.count] = left.my_sort!(&block) + [pivot] + right.my_sort!(&block)
  end

  def my_sort(&block)
    self.dup.my_sort!(&block)
  end

end

def eval_block(*arg, &block)
  block ||= proc { puts "No Given Block!" }
  block.call(*arg)
end
