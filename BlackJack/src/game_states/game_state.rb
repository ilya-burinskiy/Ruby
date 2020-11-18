class GameState

  def initialize(game)
    @game = game
  end

  def get_state
    raise "get_state not implemented"
  end

  def game_actions(game_interface)
    raise "game_actions not implemented"
  end

  protected
  attr_accessor :game

end