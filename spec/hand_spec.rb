require 'rspec'
require 'hand'

describe Hand do

  let(:cards) do
    cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack),
      Card.new(:spades, :ten),
      Card.new(:spades, :ace)
    ]
    end

  describe '#initialize' do
    it 'hand intializes with 5 cards' do
      hand = Hand.new(cards)
      expect(hand.count).to eq(5)
    end

  end

end
