require 'rspec'
require 'hand'

describe Hand do
  context "When discarding and drawing" do
    let(:deck) { double(:deck) }
    subject(:hand) { Hand.new(deck) }

    before(:each) do
      allow(deck).to receive(:take).with(5).and_return([1, 2, 3, 4, 5])
      allow(deck).to receive(:take).with(2).and_return([6, 7])
    end

    describe "#initialize" do
      it "creates an array of 5 cards" do
        expect(hand.cards.count).to eq(5)
      end
    end

    describe "#discard" do
      it "discards the indicated cards" do
        hand.discard([1, 3])
        expect(hand.cards).to_not include(2)
        expect(hand.cards).to_not include(4)
      end
    end

    describe "#draw" do
      it "receives the indicated cards" do
        hand.discard([1, 3])
        hand.draw(2)
        expect(hand.cards).to include(6)
        expect(hand.cards).to include(7)
      end
    end

    describe "#discard_and_draw" do
      it "calls #discard and #draw methods" do
        hand.discard_and_draw([1, 3])
        expect(hand.cards).to eq([1, 3, 5, 6, 7])
      end
    end
  end

  context "When evaluating hands" do
    describe "#pair" do
      it "should set @hand_value to 2" do
        hand = Hand.new([4, 9, ])
      end
    end
  end
end
