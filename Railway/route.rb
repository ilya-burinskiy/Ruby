class Route

  attr_reader :intermediate_stations
  attr_reader :dispatch_station
  attr_reader :terminal_station

  def initialize(dispatch_station, terminal_station)
    @dispatch_station = dispatch_station
    @terminal_station = terminal_station
    @intermediate_stations = []
  end

  def add_station(station)
    self.intermediate_stations << station
  end

  def remove_station(station)
    self.intermediate_stations.delete(station)
  end

  def print_route()
    puts self.dispatch_station
    self.intermediate_stations.each do |station|
      puts station
    end
    puts self.terminal_station
  end


end