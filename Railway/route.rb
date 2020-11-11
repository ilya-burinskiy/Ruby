# frozen_string_literal: true

require_relative 'instances_counter'

class Route
  include InstancesCounter
  attr_reader :intermediate_stations, :dispatch_station, :terminal_station

  def initialize(dispatch_station, terminal_station)
    @dispatch_station = dispatch_station
    @terminal_station = terminal_station
    @intermediate_stations = []

    register_instance
  end

  def add_station(station)
    intermediate_stations << station
  end

  def remove_station(station)
    intermediate_stations.delete(station)
  end

  def stations
    [dispatch_station, *intermediate_stations, terminal_station]
  end

  def station_next_to(station)
    station_idx = stations.index(station)
    stations.fetch(station_idx + 1, nil)
  end

  def station_previous_to(station)
    station_idx = stations.index(station)
    stations.fetch(station_idx - 1) if station_idx - 1 >= 0
  end
end
