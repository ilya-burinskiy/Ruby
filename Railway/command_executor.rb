# frozen_string_literal: true

require_relative 'train/train'
require_relative 'carriage/carg_carriage'
require_relative 'carriage/passenger_carriage'

class CommandExecutor
  def decode_command(command)
    case command
    when 1
      :create_station
    when 2
      :create_train
    when 3
      :create_route
    when 4
      :add_station_to_route
    when 5
      :add_route_to_train
    when 6
      :remove_station_from_route
    when 7
      :attach_carriage
    when 8
      :detach_carriage
    when 9
      :move_train_forward
    when 10
      :move_train_back
    when 11
      :show_train_carriages
    when 12
      :show_trains_on_station
    when 13
      :reserve_seat
    when 14
      :load_carriage
    when 15
      :stop
    else
      raise "Unknown command (code #{command})"
    end
  end

  def execute_command(command, railway, cinterface)
    case command
    when :create_station
      execute_create_station(railway, cinterface)
    when :create_train
      execute_create_train(railway, cinterface)
    when :create_route
      execute_create_route(railway, cinterface)
    when :add_station_to_route
      execute_add_station_to_route(railway, cinterface)
    when :add_route_to_train
      execute_add_route_to_train(railway, cinterface)
    when :remove_station_from_route
      execute_remove_station_from_route(railway, cinterface)
    when :attach_carriage
      execute_attach_carriage(railway, cinterface)
    when :detach_carriage
      execute_detach_carriage(railway, cinterface)
    when :move_train_forward
      execute_move_train_forward(railway, cinterface)
    when :move_train_back
      execute_move_train_back(railway, cinterface)
    when :show_train_carriages
      execute_show_train_carriages(railway, cinterface)
    when :show_trains_on_station
      execute_show_trains_on_station(railway, cinterface)
    when :reserve_seat
      execute_reserve_seat(railway, cinterface)
    when :load_carriage
      execute_load_carriage(railway, cinterface)
    end
  rescue StandardError => e
    cinterface.show_msg(e.message)
  end

  private

  def execute_create_station(railway, cinterface)
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
    train_type = railway.train_type(train_number)
    if train_type == :carg
      carriage_capacity = cinterface.read_carriage_capacity
      carriage = CargCarriage.new(carriage_capacity)
    else
      free_seats_num = cinterface.read_free_seats_num
      carriage = PassengerCarriage.new(free_seats_num)
    end
    railway.attach_carriage(train_number, carriage)
    cinterface.show_msg("A carriage was created and attached to train with number #{train_number}")
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

  def execute_show_trains_on_station(railway, cinterface)
    station_name = cinterface.read_station_name
    railway.show_trains_on_station(station_name, cinterface)
  end

  def execute_show_train_carriages(railway, cinterface)
    train_number = cinterface.read_train_number
    railway.show_train_carriages(train_number, cinterface)
  end

  def execute_reserve_seat(railway, cinterface)
    train_number = cinterface.read_train_number
    carriage_idx = cinterface.read_carriage_idx
    railway.reserve_seat(train_number, carriage_idx)
  end

  def execute_load_carriage(railway, cinterface)
    train_number = cinterface.read_train_number
    carriage_idx = cinterface.read_carriage_idx
    carg_volume = cinterface.read_carg_volume
    railway.load_carriage(train_number, carriage_idx, carg_volume)
  end
end
