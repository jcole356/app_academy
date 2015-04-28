def factors(num)
  factors = []
  i = 1
  while i <= num
    factors << i if num % i == 0
    i += 1
  end
  factors
end

def bubble_sort(array)

  sorted = false
  until sorted
    sorted = true

    (array.count - 1).times do |i|
      if array[i] > array[i+1]
        array[i],array[i+1] = array[i+1],array[i]
        sorted = false
      end
    end
  end
  array
end

def substrings(string)
  subs = []
  i = 0
  while i < string.length
    j = 1
    while (j + i) <= string.length
      subs << string.slice(i,j)
      j += 1
    end
    i += 1
  end
  subs
end

def subwords(string)
  english_words = []
  dictionary = File.readlines("dictionary.txt")
  dictionary.each { |word| word.chomp! }
  substrings(string).each do |sub|
    english_words << sub if dictionary.include?(sub)
  end
  english_words
end
