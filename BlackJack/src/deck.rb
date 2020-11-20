require_relative 'card'

class Deck
  DECK_SIZE = 52

  attr_reader :cards

  def initialize
    @top = DECK_SIZE - 1
    @cards = []
    fill_deck
    @cards.shuffle!
  end

  def get_top_card
    tmp = top
    self.top -= 1
    cards[tmp]
  end

  def shuffle
    self.top = DECK_SIZE - 1
    cards.shuffle!
  end

  private
  
  def fill_deck
    Card::FACES.each do |face|
      Card::SUITS.each do |suit|
        @cards << Card.new(face, suit)
      end
    end
  end

  protected

  attr_accessor :top
end
