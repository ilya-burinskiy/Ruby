require_relative 'game_state'
require_relative 'dealer_took_card'
require_relative 'user_turn'

class UserSkippedTurn < GameState
  def initialize(game)
    super(game)
  end

  def get_state
    self.class
  end

  def game_actions
    if game.get_dealer_score >= 17
      game.change_state(UserTurn.new(game))
    else
      game.give_dealer_card
      game.change_state(DealerTookCard.new(game))
    end
  end
end