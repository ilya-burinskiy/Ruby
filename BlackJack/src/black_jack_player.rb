require_relative 'player'

class BlackJackPlayer < Player
  def initialize(name, bank = 100)
    super(name, bank)
  end
end
