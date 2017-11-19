require 'byebug'
require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'hand.rb'



class GoFish
  def initialize
    @deck = Deck.new(Deck.all_cards)
    @players = []
  end

  def setup
    puts "How many players?"
    num_players = gets.chomp.to_i

    num_players.times do
      puts "Whats player name?"
      name = gets.chomp
      player = Player.new(name, @deck)
      @players << player
    end
  end

  def play
    setup

    until game_over?
      target_player_idx = current_player.prompt_target
      target_player = @players[target_player_idx]
      system ('clear')
      target_value = Card.value_key(current_player.prompt_value.upcase)
      system ('clear')
      card = current_player.take_other_player_card(target_value, target_player, @deck)

      current_player.add_points if current_player.collection?

      if card.value != target_value
        puts "Next players turn!\n"
        rotate_player
      else
        puts "#{current_player.name} goes again.\n"
      end


      # debugger
    end
    # debugger
    puts "Congratz #{self.winner.name}! You had #{self.winner.points} collections!"
  end

  def current_player
    @players[0]
  end

  def rotate_player
    @players.rotate!(1)
  end

  def game_over?
    @players.all? { |player| player.hand.empty? } || @deck.empty?
  end

  def winner
    # debugger
    max_points = 0
    player_win = nil

    @players.each do |player|
      # debugger
      if player.points > max_points
        max_points = player.points
        player_win = player
      end
    end

    player_win
  end

end

if $PROGRAM_NAME == __FILE__
  game = GoFish.new
  game.play
end
