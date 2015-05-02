class Card

  attr_reader :suit, :value

  SUITS = [:spades, :hearts, :diamonds, :clubs]

  VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def self.suits
    SUITS
  end

  def self.values
    VALUES
  end
end
