class ConsoleInterface

  def read_station_name
    print "Enter station name: "
    station_name = gets.chomp
  end

  def read_train_number
    print "Enter train number: "
    train_number = gets.chomp
  end

  def read_train_type
    print "Enter train type: "
    train_type = gets.chomp.downcase
  end

  def read_route_name
    print "Enter route name: "
    route_name = gets.chomp
  end
end