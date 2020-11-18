require_relative 'game_state'
require_relative 'user_turn'

class Start < GameState

  def initialize(game)
    super(game)
  end

  def get_state
    self.class
  end

  def game_actions
    game.deal_cards
    game.players_bet
    game.change_state(UserTurn.new(game))
  end

end