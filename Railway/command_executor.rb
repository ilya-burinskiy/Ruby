# frozen_string_literal: true

class CommandExecutor
  def execute(command, railway, cinterface)
    case command
    when 1
      station_name = cinterface.read_station_name
      railway.create_station(station_name)
      cinterface.show_msg("Station with name #{station_name} was created")
    when 2
      train_number = cinterface.read_train_number
      train_type = cinterface.read_train_type
      railway.create_train(train_number, train_type)
      cinterface.show_msg("#{train_type.capitalize} train with number #{train_number} was created")
    when 3
      route_name = cinterface.read_route_name
      dispatch_station_name = cinterface.read_station_name
      terminal_station_name = cinterface.read_station_name
      railway.create_route(route_name, dispatch_station_name, terminal_station_name)
      cinterface.show_msg("Route with name #{route_name} was created")
    when 4
      route_name = cinterface.read_route_name
      station_name = cinterface.read_station_name
      railway.add_station_to_route(route_name, station_name)
      cinterface.show_msg("#{station_name} was added to route with name #{route_name}")
    when 5
      route_name = cinterface.read_route_name
      station_name = cinterface.read_station_name
      railway.remove_station_from_route(route_name, station_name)
      cinterface.show_msg("#{station_name} was deleted from route with name #{route_name}")
    when 6
      route_name = cinterface.read_route_name
      train_number = cinterface.read_train_number
      railway.add_route_to_train(route_name, train_number)
      cinterface.show_msg("Route with name #{route_name} was added to train with number #{train_number}")
    when 7
      train_number = cinterface.read_train_number
      railway.attach_carriage(train_number)
      cinterface.show_msg("A carriage was attached to train with number #{train_number}")
    when 8
      train_number = cinterface.read_train_number
      railway.detach_carriage(train_number)
      cinterface.show_msg("A carriage was detached from train with number #{train_number}")
    when 9
      train_number = cinterface.read_train_number
      railway.move_train_forward(train_number)
      cinterface.show_msg("A train whith number #{train_number} went to the next station")
    when 10
      train_number = cinterface.read_train_number
      railway.move_train_back(train_number)
      cinterface.show_msg("A train whith number #{train_number} went to the previous station")
    end
  rescue StandardError => e
    cinterface.show_msg(e.message)
  end
end
