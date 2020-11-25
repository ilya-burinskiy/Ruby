require_relative 'game_state'
require_relative 'calc_results'

class DealerSkippedTurn < GameState
  def initialize(game)
    super(game)
  end

  def get_state
    self.class
  end

  def game_actions
    game.show_players_info
    choices = ['s - skip turn', 'o - open cards']
    game.show_choices(choices)
    choice = game.get_user_choice
    game.change_state(CalcResults.new(game)) if choice == :open_cards
  end
end
