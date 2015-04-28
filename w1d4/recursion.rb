#require 'byebug'

def range(min, max)
  return [] if max < min
  range(min, max - 1) << max
end

def range_iterative(min, max)
  result = []
  (min..max).each { |n| result << n }
  result
end

def exp1(number, exponent)
  return 1 if exponent == 0
  number * exp1(number, exponent - 1)
end

def exp2(number, exponent)
  return 1 if exponent == 0
  if number.even?
    exp2(number, exponent / 2) * exp2(number, exponent / 2)
  else
    number * (exp2(number, (exponent - 1) / 2)) * (exp2(number, (exponent - 1) / 2))
  end
end

#Should probably review this one further later

def deep_dup(array)
  return array if !array.is_a?(Array)
  array_copy = []
  array.each do |x|
    array_copy << deep_dup(x)
  end
  array_copy
end

def fibonacci_iterative(n)
  return []    if n == 0
  return [0]   if n == 1
  sequence = [0,1]
  (n-2).times { sequence << (sequence[-2] + sequence[-1]) }
  sequence
end

# I dont' remember coming up with this code.
def fibonacci(n)
  return [0, 1][0...n] if n <= 2
  sequence = fibonacci(n - 1)
  sequence << (sequence[-2] + sequence[-1])
end


# Spent a lot of time on this, should probably look at this again later.
# Commented out version worked. Most of the code I left as active is crap.
def bsearch(arr, target)
  #base case find against single element
  if arr.count == 1
    if arr[0] == target
      return 0
    else
      return nil
    end
  end

  midpoint = (arr.count / 2)
  left, right = arr[0...midpoint], arr[midpoint..-1]

  if left.last >= target
    result = bsearch(left, target)
    result
  else
    next_result = bsearch(right, target)
    result = midpoint + next_result unless next_result == nil
    result
  end
end

# #this is the partial solution for make change
# def make_change(change, coins)
#   return [] if change == 0
#   return nil if coins.count == 0 && change != 0
#
#   current_coin = coins.first
#   if change / current_coin >= 1
#     results = [current_coin] + make_change(change - current_coin, coins)
#   else
#     coins.shift
#     results = make_change(change, coins)
#   end
# end

def make_change(change, coins = [25, 10, 5, 1])
  return [] if change == 0
  return nil if coins.count == 0 && change != 0

  current_coin = coins.first
  if change / current_coin >= 1
    results = [current_coin] + make_change(change - current_coin, coins)
    next_results = make_change(change - current_coin, coins.shift)
    greedy_results = [current_coin] + next_results unless next_results == nil
    results = greedy_results if greedy_results.length < results.length
  else
    coins.shift
    results = make_change(change, coins)
  end
end
