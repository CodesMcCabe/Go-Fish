require_relative 'card.rb'

class Hand
  def self.create_hand(deck)
    cards = deck.take(5)
    Hand.new(cards)
  end

  def initialize(cards)
    @cards = cards
    @points = 0 # maybe player should hold points?
  end

  def count
    @cards.count
  end

  def favorite_value
    value_hash = Hash.new(0)

    @cards.each do |card|
      value_hash[card.value] += 1
    end

    max_value = value_hash.values.max

    value_hash.select { |_, v| v == max_value }
  end

  def draw_card
    @cards += deck.take(1)
  end

  def take_other_player_card(card)
    @cards += card
  end

  def collection?
    favorite_value.values[0] == 4
  end

  def points
    @points += 1 if collection?
    remove_cards(favorite_value)
  end

  def remove_cards(favorite_value)
    collection = favorite_value.keys[0]
    duped_cards = @cards.dup
    duped_cards.each do |card|
      @cards.delete(card.value == collection)
    end
  end

end
