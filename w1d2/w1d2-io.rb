def guessing_game
  num = rand(100) + 1
  guess = 0
  guesses = 0

  until num == guess
    puts "Guess a number:"
    guess = Integer(gets)
    guesses += 1
    if guess > num
      puts "Lower"
    elsif num > guess
      puts "Higher"
    else
      next
    end
  end

  "Good guess! It took you #{guesses} tries."

end

def shuffle_text
  puts "Enter a file name for shuffling:"
  file_name = gets.chomp
  text = File.readlines(file_name)
  File.open("#{file_name}-shuffled.txt","w") do |f|
    f.puts text.shuffle!
  end
end

def rpn_calculator
  inputs = []
  output = []
  input = nil
  puts "Enter an operand or operator (enter = to compute):"
  until inputs.last == "="
    inputs << gets.chomp
  end

  inputs.each do |item|
      add if item == "+"
      subtract if item == "-"
      multiply if item == "*"
      divide if item == "/"

      output << item

end

def add
  sum = inputs.pop + inputs.pop
end
