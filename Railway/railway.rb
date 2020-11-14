# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train/carg_train'
require_relative 'train/passenger_train'
require_relative 'carriage/carg_carriage'
require_relative 'carriage/passenger_carriage'

class Railway
  attr_reader :stations, :trains, :routes

  def initialize
    @routes = {}
  end

  def show_commands(commands)
    commands.each do |command|
      puts command
    end
  end

  def create_station(station_name)
    station_does_not_exist?(station_name)
    Station.new(station_name)
  end

  def create_train(train_number, train_type)
    train_does_not_exist?(train_number)

    case train_type
    when 'carg'
      CargTrain.new(train_number)
    when 'passenger'
      PassengerTrain.new(train_number)
    else
      raise 'Unknown train type'
    end
  end

  def create_route(route_name, dispatch_station_name, terminal_station_name)
    route_does_not_exist?(route_name)
    station_exist?(dispatch_station_name)
    station_exist?(terminal_station_name)
    add_route(route_name, dispatch_station_name, terminal_station_name)
  end

  def add_station_to_route(route_name, station_name)
    route_exist?(route_name)
    station_exist?(station_name)
    find_route(route_name).add_station(find_station(station_name))
  end

  def remove_station_from_route(route_name, station_name)
    route_exist?(route_name)
    station_exist?(station_name)
    find_route(route_name).remove_station(find_station(station_name))
  end

  def add_route_to_train(route_name, train_number)
    route_exist?(route_name)
    train_exist?(train_number)
    find_train(train_number).add_route(find_route(route_name))
  end

  def attach_carriage(train_number, carriage)
    train_exist?(train_number)
    find_train(train_number).attach_carriage(carriage)
  end

  def detach_carriage(train_number)
    train_exist?(train_number)
    find_train(train_number).detach_carriage
  end

  def move_train_forward(train_number)
    train_exist?(train_number)
    find_train(train_number).move_forward
  end

  def move_train_back(train_number)
    train_exist?(train_number)
    find_train(train_number).move_back
  end

  def show_trains_on_station(station_name, cinterface)
    station_exist?(station_name)
    cinterface.show_trains_on_station(find_station(station_name))
  end

  def show_train_carriages(train_number, cinterface)
    train_exist?(train_number)
    cinterface.show_train_carriages(find_train(train_number))
  end

  def reserve_seat(train_number, carriage_idx)
    train_exist?(train_number)
    is_train_passenger?(train_number)
    train = find_train(train_number)
    train.carriage_exist?(carriage_idx)
    train.find_carriage(carriage_idx).reserve_seat
  end

  def load_carriage(train_number, carriage_idx, carg_volume)
    train_exist?(train_number)
    is_train_carg?(train_number)
    train = find_train(train_number)
    train.carriage_exist?(carriage_idx)
    train.find_carriage(carriage_idx).load_carg(carg_volume)
  end

  def train_type(train_number)
    train_exist?(train_number)
    find_train(train_number).type
  end

  def find_train(train_number)
    Train.find(train_number)
  end

  def find_station(station_name)
    Station.find(station_name)
  end

  def find_route(route_name)
    routes.fetch(route_name, nil)
  end

  def route_does_not_exist?(route_name)
    raise "Route with name #{route_name} already exist" unless find_route(route_name).nil?

    true
  end

  def station_does_not_exist?(station_name)
    raise "Station with name #{station_name} already exist" unless find_station(station_name).nil?

    true
  end

  def train_does_not_exist?(train_number)
    raise "Train with number #{train_number} already exist" unless find_train(train_number).nil?

    true
  end

  def route_exist?(route_name)
    raise "Route with name #{route_name} does not exist" if find_route(route_name).nil?

    true
  end

  def station_exist?(station_name)
    raise "Station with name #{station_name} does not exist" if find_station(station_name).nil?

    true
  end

  def train_exist?(train_number)
    raise "Train with number #{train_number} does not exist" if find_train(train_number).nil?

    true
  end

  def is_train_passenger?(train_number)
    raise "Train with number #{train_number} is not passenger" if find_train(train_number).type == :carg

    true
  end

  def is_train_carg?(train_number)
    raise "Train with number #{train_number} is not carg" if find_train(train_number).type == :passenger

    true
  end

  private

  def add_route(route_name, dispatch_station_name, terminal_station_name)
    routes[route_name] = Route.new(find_station(dispatch_station_name),
                                   find_station(terminal_station_name))
  end

  attr_writer :stations, :trains, :routes
end
