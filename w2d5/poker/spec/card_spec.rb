require 'rspec'
require 'card'

describe Card do

  describe "#initialize" do
    subject(:card) { Card.new(:hearts, 7) }

    it "initializes a card with a suit and value" do
      expect(card.suit).to eq(:hearts)
      expect(card.value).to eq(7)
    end
  end
end
