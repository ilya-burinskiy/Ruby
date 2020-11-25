require_relative 'game'
require_relative 'game_states/game_over'

def main
  bj = Game.new
  bj.game_actions while bj.get_state != GameOver
end

main
