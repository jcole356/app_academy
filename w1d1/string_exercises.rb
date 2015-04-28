def num_to_s(num, base)
  result = ""
  char = { 0 => "0", 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6",
           7 => "7", 8 => "8", 9 => "9", 10 => "A", 11 => "B", 12 => "C", 13 => "D",
           14 => "E", 15 => "F"}
  return "0" if num == 0
  pow = 0
  while num > 0
      digit = (num / (base ** pow)) % base
      result << char[digit]
      num -= (digit * base ** pow)
  pow += 1
  end
  result.reverse
end

p num_to_s(234, 10)
p num_to_s(234, 2)
p num_to_s(234, 16)
p num_to_s(256, 16)
p num_to_s(15, 16)

def caesar(str, move)
  result = ""
  str.each_char do |char|
    new_ord = char.ord + move
    new_ord -= 26 if new_ord > 122
    result << new_ord.chr
  end

  result
end

#p caesar("zany", 2)
#p caesar("hello", 3)
