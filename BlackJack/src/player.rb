require_relative 'hand'

class Player
  attr_reader :name, :bank

  def initialize(name, bank)
    @name = name
    @bank = bank
    @hand = Hand.new
  end

  def get_score
    hand.get_score
  end

  def bet(bet_val)
    self.bank -= bet_val
    bet_val
  end

  def take_win(win_val)
    self.bank += win_val
  end

  def take_card(card)
    hand.put_card(card)
  end

  def reset_hand
    hand.reset
  end

  def get_cards
    hand.cards
  end

  protected

  attr_writer :bank
  attr_accessor :hand
end
