require_relative '../user_choice'
require_relative 'game_state'
require_relative 'user_skipped_turn'
require_relative 'user_took_card'
require_relative 'calc_results'

class UserTurn < GameState

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
    if choice == UserChoice::SKIP_TURN
      game.change_state(UserSkippedTurn.new(game))
    elsif choice == UserChoice::TAKE_CARD
      game.give_user_card
      game.change_state(UserTookCard.new(game))
    elsif choice == UserChoice::OPEN_CARDS
      game.change_state(CalcResults.new(game))
    end
  end

end