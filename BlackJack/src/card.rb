require_relative 'face'
require_relative 'suit'

class Card

  attr_reader :face, :suit
  
  def initialize(face, suit)
    @face = face
    @suit = suit
  end

  def get_score(player_score)
    score = 0

    case face
    when Face::ACE
      if 11 + player_score <= 21
        score = 11
      else
        score = 1
      end
    when Face::TWO
      score = 2
    when Face::THREE
      socre = 3
    when Face::FOUR
      score = 4
    when Face::FIVE
      score = 5
    when Face::SIX
      score = 6
    when Face::SEVEN
      score = 7
    when Face::EIGHT
      score = 8
    when Face::NINE
      score = 9
    when Face::TEN, Face::JACK, Face::QUEEN, Face::KING
      score = 10
    end

  end

  def get_card_unicode
    unicode = 0x1F000
    case face
    when Face::ACE
      unicode += 0x1
    when Face::TWO
      unicode += 0x2
    when Face::THREE
      unicode += 0x3
    when Face::FOUR
      unicode += 0x4
    when Face::FIVE
      unicode += 0x5
    when Face::SIX
      unicode += 0x6
    when Face::SEVEN
      unicode += 0x7
    when Face::EIGHT
      unicode += 0x8
    when Face::NINE
      unicode += 0x9
    when Face::TEN
      unicode += 0xA
    when Face::JACK
      unicode += 0xB
    when Face::QUEEN
      unicode += 0xD
    when Face::KING
      unicode += 0xE
    end

    case suit
    when Suit::SPADES
      unicode += 0xA0
    when Suit::HEARTS
      unicode += 0xB0
    when Suit::DIAMONDS
      unicode += 0xC0
    when Suit::CLUBS
      unicode += 0xD0
    end

    '' << unicode
  end

  def get_card_back_unicode
    '' << 0x1F0A0
  end

end