# frozen_string_literal: true

class ConsoleInterface
  def show_instructions(instructions)
    instructions.each do |instruction|
      puts instruction
    end
  end

  def read_command
    print '>>> '
    gets.to_i
  end

  def read_station_name
    print 'Enter station name: '
    station_name = gets.chomp
  end

  def read_train_number
    print 'Enter train number: '
    train_number = gets.chomp
  end

  def read_train_type
    print 'Enter train type: '
    train_type = gets.chomp.downcase
  end

  def read_route_name
    print 'Enter route name: '
    route_name = gets.chomp
  end

  def show_msg(msg)
    puts msg
  end
end
