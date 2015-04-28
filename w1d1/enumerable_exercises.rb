def times_two(arr)
  arr.map { |n| n * 2 }
end

# p times_two([1, 2, 3])

class Array
  def my_each(&block)
    i = 0
    while i < self.length
      block.call(self[i])
      i += 1
    end

    self
  end
end

# a = [1, 2, 3]

# a.my_each do |num|
#  puts num
# end

def find_median(arr)
  arr.sort!
  arr.length.odd? ? arr[arr.length/2] : (arr[arr.length/2-1]+arr[arr.length/2])/2.0
end

#p find_median([1,2,3,4,5,6,7,8,9])
#p find_median([0,1,2,3,4,5,6,7,8,9])

def concatenate(arr)
  arr.inject("") { |string, element| string += element }
end

#p concatenate(["Yay ", "for ", "strings!"])
