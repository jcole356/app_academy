class Code
   attr_reader :code

   def initialize(code_str)
     @code = code_str.split("")
   end

   def random
     c = ""
     4.times do
       c += ['R', 'G', 'B', 'Y', 'O', 'P'].sample(1).join("")
     end
     Code.new(c)
   end

   def [](i)
     @code[i]
   end

   def parse(input)
     Code.new(input)
   end

   def exact_matches(other_code)
      exact = 0

      self.code.each_with_index do |peg, i|
        if other_code[i] == peg
          exact += 1
        end
      end

      exact
   end

   def near_matches(other_code)
     near = 0
     computer_near_matches = []
     human_near_matches = []
     self.code.each_with_index do |peg1, i|
       computer_near_matches << peg1 if other_code[i] != peg1
       human_near_matches << other_code[i] if other_code[i] != peg1
     end

     human_near_matches.sort!
     computer_near_matches.sort!

     l = human_near_matches.length
     i = 0
     while (i < l)
       h = human_near_matches.shift
       c = computer_near_matches.shift

       if h == c
         near += 1
       end

       i+=1
     end

     near
   end

end

class Game
  def initialize
    @code = Code.new('RRRR')
    self.play
  end

  def play


    @code = @code.random
    p @code
    puts "Welcome to MASTERMIND. Can you break the code?"

    turns = 0;
    while turns < 10

      guess = prompt

      exact = @code.exact_matches(guess)
      near = @code.near_matches(guess)

      turns += 1

      if(exact == 4)
        break
      end

      puts "#{exact} exact matches, #{near} near matches, Turn: #{turns + 1}"



    end

    if turns > 10
      puts "You failed to crack the code!"
    else
      puts "You win! #{turns} turns."
    end

end



  def prompt
    loop do
      puts "Enter Code"
      str = gets.chomp
      if(str =~ /^[RGBYOP]{4}$/)
        return @code.parse(str)
      else
        puts "Invalid code!"
      end
    end
  end
end
