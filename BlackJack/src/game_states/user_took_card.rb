require_relative 'game_state'
require_relative 'dealer_skipped_turn'
require_relative 'calc_results'

class UserTookCard < GameState
  def initialize(game)
    super(game)
  end

  def get_state
    self.class
  end

  def game_actions
    if game.get_dealer_score >= 17
      game.change_state(DealerSkippedTurn.new(game))
    else
      game.give_dealer_card
      game.change_state(CalcResults.new(game))
    end
  end
end
