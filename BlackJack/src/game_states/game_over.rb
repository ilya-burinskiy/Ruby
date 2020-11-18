require_relative 'game_state'

class GameOver < GameState
  def initialize(game)
    super(game)
  end

  def get_state
    self.class
  end

  def game_actions
  end

end