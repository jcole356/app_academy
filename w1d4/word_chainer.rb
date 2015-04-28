require 'byebug'

class WordChainer

  attr_reader :dictionary

  def initialize(dictionary_file_name)
    @dictionary = Set.new dictionary_array(dictionary_file_name)
  end

  def adjacent_words(word)
    adjacent_words = []
    word.each_char.with_index do |old_letter, i|
      ('a'..'z').each do |letter|
        next if letter == old_letter

        new_word = word.dup
        new_word[i] = letter

        adjacent_words << new_word if dictionary.include?(new_word)
      end
    end

    adjacent_words
  end

  def dictionary_array(dictionary_file_name)
    File.readlines("#{dictionary_file_name}.txt").map { |word| word.chomp}
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |adj_word|
        next if @all_seen_words.include?(adj_word)

        new_current_words << adj_word
        @all_seen_words << adj_word
      end
    end

    @current_words = new_current_words
  end

  def run(source) #, target = nil)
    @current_words = [source]
    @all_seen_words = [source]

    until @current_words.empty?
      explore_current_words
    end
  end
end


x = WordChainer.new("dictionary")
# p x.adjacent_words("happy")
p x.run("happy")
