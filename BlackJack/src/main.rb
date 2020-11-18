require_relative 'game'
require_relative 'game_states/game_over'

def main
  bj = Game.new
  while bj.get_state != GameOver
    bj.game_actions
  end
end

main