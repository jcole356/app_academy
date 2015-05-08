require_relative 'deck'

class Hand
  attr_reader :cards, :hand_value

  HAND_RANKINGS = { straight_flush:9,
                    four_kind:8,
                    full_house:7,
                    flush:6,
                    straight:5,
                    three_kind:4,
                    two_pair:3,
                    one_pair:2,
                    high_card:1,
                  }

  def initialize(deck)
    @deck = deck
    @cards = deck.take(5).sort!
    @hand_value = 0
  end

  def discard(indices)
    indices.each { |idx| @cards[idx] = nil }
    @cards.compact!
  end

  def discard_and_draw(indices)
    discard(indices)
    draw(indices.size).sort!
  end

  def draw(num)
    @cards += @deck.take(num)
  end

  def hand_rankings
    HAND_RANKINGS
  end

  def render
    @cards
  end
end
