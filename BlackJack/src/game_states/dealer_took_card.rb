require_relative 'game_state'
require_relative 'calc_results'

class DealerTookCard < GameState
  def initialize(game)
    super(game)
  end

  def get_state
    self.class
  end

  def game_actions
    game.show_players_info
    choices = ['s - skip turn', 't - take card', 'o - open cards']
    game.show_choices(choices)
    choice = game.get_user_choice
    if %i[take_card open_cards].include?(choice)
      game.give_user_card if choice == :take_card
      game.change_state(CalcResults.new(game))
    end
  end
end
