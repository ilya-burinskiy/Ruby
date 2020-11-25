require_relative 'player'

class Dealer < Player
  def initialize(bank = 100)
    super('Dealer', bank)
  end
end
