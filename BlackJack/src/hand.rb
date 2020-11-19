class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def put_card(card)
    cards << card
  end

  def get_score
    score = 0
    cards.each do |card|
      score += card.score(score)
    end

    score
  end

  def cards_number
    cards.length
  end

  def reset
    self.cards = []
  end

  protected

  attr_writer :cards
end
