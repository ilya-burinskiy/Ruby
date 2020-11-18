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
    if choice == UserChoice::TAKE_CARD || choice == UserChoice::OPEN_CARDS
      game.give_user_card if choice == UserChoice::TAKE_CARD
      game.change_state(CalcResults.new(game))
    end
  end

end