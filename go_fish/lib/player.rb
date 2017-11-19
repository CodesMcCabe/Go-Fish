require_relative 'hand.rb'

class Player #how do we associate the hand to the player?
  attr_reader :hand, :points, :name

  def initialize(name, deck)
    @name = name
    @hand = Hand.create_hand(deck)
    @points = 0
  end

  # player method
  def draw_card(deck)
    card = deck.take(1)
    @hand.cards += card
    card[0]
  end

  # player method
  def take_other_player_card(card_value, other_player, deck)
    if other_player.hand.include?(card_value)

      card = other_player.give_card(card_value)

      other_player.hand.cards.delete(card) # can write hand method to remove cards
      @hand.cards += [card] # can write a method to add cards to hand

      card
    else
      draw_card(deck)
    end
  end

  def give_card(card_value)
    @hand.cards.each do |card|
      return card if card.value == card_value
    end
  end

  # player method
  def collection?
    @hand.favorite_value.values[0] == 4
  end

  # player method
  def add_points
    if collection?
      @points += 1
      @hand.remove_cards(@hand.favorite_value)
    end
  end

   # add error raise if reqest is larger than total players
  def prompt_target
    puts "#{@name}, what player do you want to ask?"
    requested_player = gets.chomp.to_i # user will input a number from 1..players.length
  end

  def prompt_value
    puts "#{@name}, what value do you seek?"
    requested_value = gets.chomp
  end

end
