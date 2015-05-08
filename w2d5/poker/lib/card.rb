class Card

  attr_reader :suit, :value

  SUITS = [:spades, :hearts, :diamonds, :clubs]

  VALUES = { ace:1,
             two:2,
             three:3,
             four:4,
             five:5,
             six:6,
             seven:7,
             eight:8,
             nine:9,
             ten:10,
             jack:11,
             queen:12,
             king:13
            }

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def self.suits
    SUITS
  end

  def self.values
    VALUES.keys
  end
end
