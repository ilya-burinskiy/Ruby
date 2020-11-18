require_relative 'dealer'
require_relative 'black_jack_player'
require_relative 'deck'
require_relative 'console_interface'
require_relative 'game_states/start'

class Game

  attr_reader :min_bet

  def initialize
    @game_interface = ConsoleInterface.new
    @user = BlackJackPlayer.new(@game_interface.get_user_name) 
    @dealer = Dealer.new
    @deck = Deck.new
    @min_bet = 10
    @state = Start.new(self)
  end

  def game_actions
    state.game_actions
  end

  def change_state(new_state)
    self.state = new_state
  end

  def get_state
    state.get_state
  end

  def deal_cards(n = 2)
    (1..n).each do
      user.take_card(deck.get_top_card)
      dealer.take_card(deck.get_top_card)
    end
  end

  def players_bet
    self.user_bet = user.bet(min_bet)
    self.dealer_bet = dealer.bet(min_bet)
  end 

  def choose_winner
    winner = nil
    user_score = user.get_score
    dealer_score = dealer.get_score
    user_diff = 21 - user_score
    dealer_diff = 21 - dealer_score

    if (user_score == dealer_score)
      user.take_win(user_bet)
      dealer.take_win(user_bet)
      return winner
    end

    if (user_score <= 21 && dealer_score <= 21)
      winner = user_diff < dealer_diff ? user : dealer
    elsif user_score > 21 && dealer_score > 21
      winner = user_diff > dealer_diff ? user : dealer
    elsif user_score <= 21 && dealer_score > 21
      winner = user
    elsif dealer_score <= 21 && user_score > 21
      winner = dealer
    end

    winner.take_win(user_bet + dealer_bet)

    return winner
  end

  def get_user_bank
    user.bank
  end

  def get_dealer_bank
    dealer.bank
  end

  def give_user_card
    user.take_card(deck.get_top_card)
  end

  def give_dealer_card
    dealer.take_card(deck.get_top_card)
  end

  def reset_hands
    user.reset_hand
    dealer.reset_hand
  end

  def shuffle_deck
    deck.shuffle
  end

  def show_players_info(hide_dealer_info = true)
    game_interface.show_player_info(user)
    game_interface.show_player_info(dealer, hide_dealer_info)
  end

  def show_choices(choices)
    game_interface.show_choices(choices)
  end

  def get_user_choice
    game_interface.get_user_choice
  end

  def get_dealer_score
    dealer.get_score
  end

  def show_message(msg)
    game_interface.show_message(msg)
  end

  private
  attr_accessor :user, :dealer, :deck, :user_bet, :dealer_bet, :game_interface, :state
  attr_writer :min_bet
end