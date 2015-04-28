require 'byebug'
require 'io/console'
class Hangman
  attr_reader :guessing_player, :checking_player

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    word_length = guessing_player.receive_secret_length
    secret_word = checking_player.pick_secret_word(word_length)
    word_state = ""
    (secret_word.size).times do |i|
      word_state += "_"
    end

    turns = 0
    #p secret_word
    while turns < 6 && word_state != secret_word
      puts "Guess a letter"

      guess = guessing_player.guess(word_length,word_state)

      if checking_player.check_guess(secret_word,guess) == true
        word_state = checking_player.handle_guess_response(secret_word,word_state,guess)
        guessing_player.correct_guess(guess)
      else
        word_state = checking_player.handle_guess_response(secret_word,word_state,"")
        guessing_player.incorrect_guess(guess)
        turns += 1
      end

    end

    if word_state == secret_word
      puts "Congratulations, the word was #{secret_word}"
    else
      puts "The jig is up, the word was #{secret_word}"
    end
  end

end

class HumanPlayer
  def pick_secret_word(length)
    puts "Give me a word of length #{length}"
    loop do

      str = STDIN.noecho(&:gets).chomp
      if(str.size - 1 != length)
       return str
      else
       puts "Wrong word size."
      end
    end
  end

  def receive_secret_length
    puts "How many letters?"
    gets.chomp.to_i
  end

  def guess(length,word_state)
    gets.chomp
  end

  def correct_guess(g)
  end

  def incorrect_guess(g)
  end

  def check_guess(word,guess)
    word.split("").each do |l|
      if(l == guess)
        return true
      end
    end
    false
  end

  def handle_guess_response(word,word_state,guess)
    if guess == ""
      puts "Letter is not in the word!"
      puts "#{word_state}"
      return word_state
    end

    letters = word.split("")
    word_array = word_state.split("")
    letters.each_with_index do |l, i|
      word_array[i] = guess if l == guess
    end
    word_state = word_array.join("")
    puts word_state

    return word_state
  end

end

class ComputerPlayer

  def initialize
    @dictionary = File.readlines('dictionary.txt').map {|line| line.chomp}
    @letters = ('a'..'z').to_a
    @correct_letters = []
    @incorrect_letters = []
  end

  def pick_secret_word(length)
    words = @dictionary.select { |word| word.size == length }
    words.sample(1)[0]
  end

  def receive_secret_length
    rand(3..10)
  end

  def guess(length, word_state)

    #letter = ('a'..'z').to_a.sample(1).join("")
    #until @letters.include?(letter)
    #  letter = ('a'..'z').to_a.sample(1).join("")
    #end

    letter = guess_smart(length,word_state)

    @letters.delete(letter)
    puts "#{letter}"
    letter
  end

  def guess_smart(length, word_state)
    cl_words = @dictionary.select { |word| word.size == length }
    cl_words = filter_incorrect(cl_words)
    cl_words = filter_correct(cl_words,word_state)
    letter_counts = {}
    @letters.each do |l|
      letter_counts[l] = 0
    end

    cl_words.each do |word|
      word.each_char do |l|
        letter_counts[l] += 1 if letter_counts.has_key?(l)
      end
    end

    largest_hash_key(letter_counts)
  end

  def filter_correct(words, word_state)
    new_words = []
    words.each do |word|
      word_match = true
      word.each_char.with_index do |l,i|
        if word_state[i] != "_"
          if word_state[i] != l
            word_match = false
          end
        end
      end
      if word_match == true
        new_words << word
      end
    end
    new_words
  end

  def filter_incorrect(words)
    new_words = []
    words.each do |word|
      contains_incorrect = false
      word.each_char do |c|
        if(@incorrect_letters.include?(c))
          contains_incorrect = true
        end
      end
      if contains_incorrect == false
        new_words << word
      end
    end
    new_words
  end

  def largest_hash_key(letter_counts)
    letter_counts.max_by{|k,v| v}[0]
  end

  def check_guess(word,guess)
    word.split("").each do |l|
      if(l == guess)
        return true
      end
    end
    false
  end

  def correct_guess(g)
    @correct_letters << g
  end

  def incorrect_guess(g)
    @incorrect_letters << g
  end

  def handle_guess_response(word,word_state,guess)
    if guess == ""
      puts "Letter is not in the word!"
      puts "#{word_state}"
      return word_state
    end

    letters = word.split("")
    word_array = word_state.split("")
    letters.each_with_index do |l, i|
      word_array[i] = guess if l == guess
    end
    word_state = word_array.join("")
    puts word_state

    return word_state
  end
end


if __FILE__ == $PROGRAM_NAME

  h = HumanPlayer.new
  c2 = ComputerPlayer.new

  g = Hangman.new(h, c2)
  g.play
end
