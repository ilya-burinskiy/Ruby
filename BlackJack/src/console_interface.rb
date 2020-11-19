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
      choice = case input
               when 's'
                 :skip_turn
               when 't'
                 :take_card
               when 'o'
                 :open_cards
               when 'y'
                 :yes
               when 'n'
                 :no
               else
                 :wrong_choice
               end
      break if choice != :wrong_choice
    end

    choice
  end

  def show_player_info(player, hide = false)
    puts "#{player.name} score: #{player.get_score}" unless hide
    print "#{player.name} cards: "
    card_unicode = nil
    player.get_cards.each do |card|
      card_unicode = if hide
                       card.back_unicode
                     else
                       card.unicode
                     end
      card_unicode = '' << card_unicode
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
