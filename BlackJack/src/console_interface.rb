require_relative 'user_choice'

class ConsoleInterface

  def get_user_name
    print 'Enter your name: '
    name = gets.chomp
  end

  def get_user_choice
    choice = nil
    loop do
      print '>>> '
      input = gets.chomp.downcase
      case input
      when 's'
        choice = UserChoice::SKIP_TURN
      when 't'
        choice = UserChoice::TAKE_CARD
      when 'o'
        choice = UserChoice::OPEN_CARDS
      when 'y'
        choice = UserChoice::YES
      when 'n'
        choice = UserChoice::NO
      else
        choice = UserChoice::WRONG_CHOICE
      end
      break if choice != UserChoice::WRONG_CHOICE
    end

    choice
  end

  def show_player_info(player, hide = false)
    puts "#{player.name} score: #{player.get_score}" unless hide
    print "#{player.name} cards: "
    card_unicode = nil
    player.get_cards.each do |card|
      if hide
        card_unicode = card.get_card_back_unicode
      else
        card_unicode = card.get_card_unicode
      end
      print "#{card_unicode} "
    end
    puts
  end

  def show_choices(choices)
    choices.each { |choice| puts choice }
  end

  def show_message(msg)
    puts msg
  end

end