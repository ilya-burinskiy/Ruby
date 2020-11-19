require_relative 'card'

class Deck
  DECK_SIZE = 52

  attr_reader :cards

  def initialize
    @top = DECK_SIZE - 1
    @cards = []

    Card.faces.each do |face|
      Card.suits.each do |suit|
        @cards << Card.new(face, suit)
      end
    end
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

  protected

  attr_accessor :top
end
