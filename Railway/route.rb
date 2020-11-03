class Route

  attr_reader :intermediate_stations, :dispatch_station, :terminal_station

  def initialize(dispatch_station, terminal_station)
    @dispatch_station = dispatch_station
    @terminal_station = terminal_station
    @intermediate_stations = []
  end

  def add_station(station)
    intermediate_stations << station
  end

  def remove_station(station)
    intermediate_stations.delete(station)
  end

  def print_route
    puts dispatch_station.name
    intermediate_stations.each do |station|
      puts station.name
    end
    puts terminal_station.name
  end

  def station_next_to(station)
    stations = [dispatch_station, *intermediate_stations, terminal_station]
    station_idx = stations.index(station)
    stations.fetch(station_idx + 1, nil)
  end

  def station_previous_to(station)
    stations = [dispatch_station, *intermediate_stations, terminal_station]
    station_idx = stations.index(station)
    stations.fetch(station_idx - 1) if station_idx - 1 >= 0
  end

end