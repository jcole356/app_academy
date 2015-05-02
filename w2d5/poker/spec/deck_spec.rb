require 'rspec'
require 'deck'

describe Deck do
  describe "#initialize" do
    it "returns an array of all 52 cards by default" do
      deck = Deck.new
      expect(deck.cards.count).to eq(52)
      expect(deck.cards).to eq(deck.cards.uniq)
    end

    it "creates a deck with the given cards passed" do
      heart = Card.new(:heart, :two)
      spade = Card.new(:spades, :king)
      deck = Deck.new([heart, spade])
      expect(deck.cards.count).to eq(2)
      expect(deck.cards).to eq([heart, spade])
    end
  end

  describe "#take" do
    it "removes a specified number of cards from the top of the deck" do
      deck = Deck.new
      card1, card2 = deck.cards[0], deck.cards[1]
      expect(deck.take(2)).to eq([card1, card2])
      expect(deck.cards.count).to eq(50)
    end

    it "raises error if you try to take more cards than there are in deck" do
      deck = Deck.new([Card.new(:clubs, :five), Card.new(:hearts, :ten)])
      expect { deck.take(3) }.to raise_error("Cannot do that")
    end
  end
end
