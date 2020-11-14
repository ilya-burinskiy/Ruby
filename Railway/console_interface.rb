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

  def read_carriage_capacity
    print 'Enter carriage capacity: '
    carriage_capacity = gets.chomp.to_f
  end

  def read_free_seats_num
    print 'Enter carriage free seats number: '
    free_seats_num = gets.chomp.to_i
  end

  def show_trains_on_station(station)
    station.trains.each { |train| puts train.number }
  end

  def show_train_carriages(train)
    train.carriages.each { |carriage| puts carriage.type }
  end

  def read_carriage_idx
    print 'Enter carriage index in train: '
    carriage_idx = gets.to_i
  end

  def read_carg_volume
    print 'Enter carg volume: '
    carg_volume = gets.to_f
  end

  def show_msg(msg)
    puts msg
  end
end
