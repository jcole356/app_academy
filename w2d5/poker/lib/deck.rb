require_relative 'card'

class Deck
  attr_reader :cards

  def initialize(cards = self.class.all_cards)
    @cards = cards
    @cards.shuffle!
  end

  def self.all_cards
    all_cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end
    all_cards
  end

  def take(n)
    raise "Cannot do that" if n > @cards.count
    @cards.shift(n)
  end
end
