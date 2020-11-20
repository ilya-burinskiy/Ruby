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

    if winner.nil?
      game.show_message('Draw')
    else
      game.show_message("Winner is #{winner.name}")
    end

    game.show_players_info(false)
    game.show_message("Your bank: #{game.get_user_bank}")

    if game.has_user_enough_money? && game.has_dealer_enough_money?
      game.show_message('Continue?')
      game.show_choices(['y - yes', 'n - no'])
      if game.get_user_choice == :yes
        game.reset_hands
        game.shuffle_deck
        game.change_state(Start.new(game))
      else
        game.change_state(GameOver.new(game))
      end
    else
      game.show_message('You have not enough money') unless game.has_user_enough_money?
      game.show_message('Dealer has not enough money') unless game.has_dealer_enough_money?
      game.change_state(GameOver.new(game))
    end
  end
end
