require_relative "railway.rb"
require_relative "console_interface.rb"

def show_commands(commands)
  commands.each do |command|
    puts command
  end
end

def main
  commands = [
    "1  - Create station",
    "2  - Create train",
    "3  - Create route (enter dispatch and terminal stations)",
    "4  - Add station to route",
    "5  - Remove station from route",
    "6  - Add route to train",
    "7  - Attach carriage",
    "8  - Detach carriage",
    "9  - Move train forwart",
    "10 - Move train back",
    "11 - Stop"
  ]
  railway = Railway.new
  cinterface = ConsoleInterface.new

  loop do
    show_commands(commands)
    command = gets.to_i

    begin

      case command
      when 1
        station_name = cinterface.read_station_name 
        railway.create_station(station_name)
      when 2
        train_number = cinterface.read_train_number
        train_type = cinterface.read_train_type
        railway.create_train(train_number, train_type)
      when 3
        route_name = cinterface.read_route_name
        dispatch_station_name = cinterface.read_station_name
        terminal_station_name = cinterface.read_station_name
        railway.create_route(route_name, dispatch_station_name, terminal_station_name)
      when 4
        route_name = cinterface.read_route_name
        station_name = cinterface.read_station_name 
        railway.add_station_to_route(route_name, station_name)
      when 5
        route_name = cinterface.read_route_name
        station_name = cinterface.read_station_name 
        railway.remove_station_from_route(route_name, station_name)
      when 6
        route_name = cinterface.read_route_name
        train_number = cinterface.read_train_number
        railway.add_route_to_train(route_name, train_number)
      when 7
        train_number = cinterface.read_train_number
        railway.attach_carriage(train_number)
      when 8
        train_number = cinterface.read_train_number
        railway.detach_carriage(train_number)
      when 9
        train_number = cinterface.read_train_number
        railway.move_train_forward(train_number)
      when 10
        train_number = cinterface.read_train_number
        railway.move_train_back(train_number)
      end

    rescue StandartError => e
      puts e.message
    end

    break if command == 11
  end
end

main