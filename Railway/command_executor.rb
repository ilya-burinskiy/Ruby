# frozen_string_literal: true

class CommandExecutor
  def execute(command, railway, cinterface)
    case command
    when 1
      execute_create_station(railway, cinterface)
    when 2
      execute_create_train(railway, cinterface)
    when 3
      execute_create_route(railway, cinterface)
    when 4
      execute_add_station_to_route(railway, cinterface)
    when 5
      execute_remove_station_from_route(railway, cinterface)
    when 6
      execute_add_route_to_train(railway, cinterface)
    when 7
      execute_attach_carriage(railway, cinterface)
    when 8
      execute_detach_carriage(railway, cinterface)
    when 9
      execute_move_train_forward(railway, cinterface)
    when 10
      execute_move_train_back(railway, cinterface)
    end
  rescue StandardError => e
    cinterface.show_msg(e.message)
  end

  def create_station_command(railway, cinterface)
    station_name = cinterface.read_station_name
    railway.create_station(station_name)
    cinterface.show_msg("Station with name #{station_name} was created")
  end

  def execute_create_train(railway, cinterface)
    train_number = cinterface.read_train_number
    train_type = cinterface.read_train_type
    railway.create_train(train_number, train_type)
    cinterface.show_msg("#{train_type.capitalize} train with number #{train_number} was created")
  end

  def execute_create_route(railway, cinterface)
    route_name = cinterface.read_route_name
    dispatch_station_name = cinterface.read_station_name
    terminal_station_name = cinterface.read_station_name
    railway.create_route(route_name, dispatch_station_name, terminal_station_name)
    cinterface.show_msg("Route with name #{route_name} was created")
  end

  def execute_add_station_to_route(railway, cinterface)
    route_name = cinterface.read_route_name
    station_name = cinterface.read_station_name
    railway.add_station_to_route(route_name, station_name)
    cinterface.show_msg("#{station_name} was added to route with name #{route_name}")
  end

  def execute_remove_station_from_route(railway, cinterface)
    route_name = cinterface.read_route_name
    station_name = cinterface.read_station_name
    railway.remove_station_from_route(route_name, station_name)
    cinterface.show_msg("#{station_name} was deleted from route with name #{route_name}")
  end

  def execute_add_route_to_train(railway, cinterface)
    route_name = cinterface.read_route_name
    train_number = cinterface.read_train_number
    railway.add_route_to_train(route_name, train_number)
    cinterface.show_msg("Route with name #{route_name} was added to train with number #{train_number}")
  end

  def execute_attach_carriage(railway, cinterface)
    train_number = cinterface.read_train_number
    railway.attach_carriage(train_number)
    cinterface.show_msg("A carriage was attached to train with number #{train_number}")
  end

  def execute_detach_carriage(railway, cinterface)
    train_number = cinterface.read_train_number
    railway.detach_carriage(train_number)
    cinterface.show_msg("A carriage was detached from train with number #{train_number}")
  end

  def execute_move_train_forward(railway, cinterface)
    train_number = cinterface.read_train_number
    railway.move_train_forward(train_number)
    cinterface.show_msg("A train whith number #{train_number} went to the next station")
  end

  def execute_move_train_back(railway, cinterface)
    train_number = cinterface.read_train_number
    railway.move_train_back(train_number)
    cinterface.show_msg("A train whith number #{train_number} went to the previous station")
  end
end
