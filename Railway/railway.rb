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
    raise 'Station already exist' if station_exist?(station_name)

    Station.new(station_name)
  end

  def create_train(train_number, train_type)
    raise 'Train already exist' if train_exist?(train_number)

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
    raise 'Route already exist' if route_exist?(route_name)
    raise "Such dispatch station doesn't exist" unless station_exist?(dispatch_station_name)
    raise "Such terminal station doesn't exist" unless station_exist?(terminal_station_name)

    routes[route_name] = Route.new(Station.find(dispatch_station_name),
                                   Station.find(terminal_station_name))
  end

  def add_station_to_route(route_name, station_name)
    raise "Such route name doesn't exist" unless route_exist?(route_name)
    raise "Such stations doesn't exist" unless station_exist?(station_name)

    routes[route_name].add_station(Station.find(station_name))
  end

  def remove_station_from_route(route_name, station_name)
    raise "Such route name doesn't exist" unless route_exist?(route_name)
    raise "Such stations doesn't exist" unless station_exist?(station_name)

    routes[route_name].remove_station(Station.find(station_name))
  end

  def add_route_to_train(route_name, train_number)
    raise "Such route name doesn't exist" unless route_exist?(route_name)
    raise "Such train doesn't exist" unless train_exist?(train_number)

    Train.find(train_number).add_route(routes[route_name])
  end

  def attach_carriage(train_number)
    raise "Such train doesn't exist" unless train_exist?(train_number)

    train = Train.find(train_number)
    if train.type == :carg
      train.attach_carriage(CargCarriage.new)
    else
      train.attach_carriage(PassengerCarriage.new)
    end
  end

  def detach_carriage(train_number)
    raise "Such train doesn't exist" unless train_exist?(train_number)

    Train.find(train_number).detach_carriage
  end

  def move_train_forward(train_number)
    raise "Such train doesn't exist" unless train_exist?(train_number)

    Train.find(train_number).move_forward
  end

  def move_train_back(train_number)
    raise "Such train doesn't exist" unless train_exist?(train_number)

    Train.find(train_number).move_back
  end

  def route_exist?(route_name)
    routes.key?(route_name)
  end

  def station_exist?(station_name)
    !Station.find(station_name).nil?
  end

  def train_exist?(train_number)
    !Train.find(train_number).nil?
  end

  private

  attr_writer :stations, :trains, :routes
end
