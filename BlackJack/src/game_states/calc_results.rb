require_relative 'game_state'
require_relative 'start'
require_relative 'game_over'

class CalcResults < GameState
  def initialize(game)
    super(game)
  end

  def get_state
    self.class
  end

  def game_actions
    winner = game.choose_winner

    unless winner.nil?
      game.show_message("Winner is #{winner.name}")
    else
      game.show_message("Draw")
    end

    game.show_players_info(false)
    game.show_message("Your bank: #{game.get_user_bank}")

    if game.get_user_bank < game.min_bet || game.get_dealer_bank < game.min_bet
      puts game.get_user_bank, game.get_dealer_bank
      if game.get_user_bank < 10
        game.show_message("You have not enough money")
      else
        game.show_message("Dealer has not enough money")
      end
      game.change_state(GameOver.new(game))
    else
      game.show_message("Continue?")
      choices = ['y - yes', 'n - no']
      game.show_choices(choices)
      choice = game.get_user_choice
      if choice == UserChoice::YES
        game.reset_hands
        game.shuffle_deck
        game.change_state(Start.new(game))
      else
        game.change_state(GameOver.new(game))
      end
    end
  end

end