require 'byebug'
require_relative 'card.rb' # dont think i need THIS


class Hand
  def self.create_hand(deck)
    cards = deck.take(5)
    Hand.new(cards)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def count
    @cards.count
  end

  def empty?
    @cards.empty?
  end

  def include?(card_value)
    @cards.any? { |card| card.value == card_value }
  end

  def refill_hand
    @cards += deck.take(5)
  end


  # can def use for AI player, however, can show the player has current favorite_value to help him make decision
  def favorite_value
    value_hash = Hash.new(0)

    @cards.each do |card|
      value_hash[card.value] += 1
    end

    max_value = value_hash.values.max

    value_hash.select { |_, v| v == max_value }
  end

  def remove_cards(favorite_value)
    collection = favorite_value.keys[0]
    duped_cards = @cards.dup
    duped_cards.each do |card|
      @cards.delete(card) if card.value == collection
    end

  end

end
