require 'rspec'
require 'towers'

describe Game do
  describe "#render" do
    context "renders starting positions of game" do
      subject(:game) { Game.new }

      it "displays starting position of game" do
        expect(game.render).to eq([[1, 2, 3], [], []])
      end
    end
  end

  describe "#move" do
    subject(:game) { Game.new }

    it "from starting position, moves top disc to second stack" do
      game.move(0, 1)
      expect(game.towers).to eq([[2, 3], [1], []])
    end

    it "raise error if user picks from empty tower" do
      expect { game.move(1, 2) }.to raise_error("Invalid move")
    end

    it "raise error if user puts a bigger disk on a smaller disk" do
      game.move(0, 1)
      expect { game.move(0, 1) }.to raise_error("Invalid move")
    end
  end

  describe "#won?" do
    subject(:game) { Game.new }

    it 'david rules' do
      game.instance_variable_set(:@towers, [[], [], [1, 2, 3]])
      expect(game.won?).to eq(true)
    end
  end
end
