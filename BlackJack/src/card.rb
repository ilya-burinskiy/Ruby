class Card
  class << self
    attr_reader :faces, :suits, :scores, :unicodes

    private

    attr_writer :faces, :suits, :scores, :unicodes

    def create_cards_unicodes
      i = 0x1
      j = 0xA0
      self.unicodes = {}
      suits.each do |suit|
        faces.each do |face|
          unicodes[[face, suit]] = 0x1F000 + j + i
          i = face == :jack ? i + 2 : i + 1
        end
        j += 0x10
        i = 0x1
      end
      unicodes[:card_back] = 0x1F0A0
    end
  end

  self.faces = %i[ace two three four five six
                  seven eight nine ten jack queen king]

  self.suits = %i[diamonds clubs hearts spades]

  self.scores = { ace: 11, two: 2, three: 3, four: 4, five: 5, six: 6,
                  seven: 7, eight: 8, nine: 9, ten: 10, jack: 10, queen: 10, king: 10 }

  create_cards_unicodes

  attr_reader :face, :suit

  def initialize(face, suit)
    @face = face
    @suit = suit
  end

  def score(player_score)
    score = self.class.scores[face]
    if face == :ace
      score -= 10 if 11 + player_score > 21
    end
    score
  end

  def unicode
    self.class.unicodes[[face, suit]]
  end

  def back_unicode
    self.class.unicodes[:card_back]
  end
end
