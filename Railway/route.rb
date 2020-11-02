class Route

  class RouteIterator

      attr_reader :stations
      attr_reader :cursor

      attr_writer :cursor

      def initialize(route, cursor)
          @stations = [route.dispatch_station, 
                      *route.intermediate_stations,
                      route.terminal_station]
          @cursor = cursor
      end

      def next()
        if self.cursor + 1 >= self.stations.length
          raise Exception.new
        self. cursor += 1
        return self.stations[cursor]
      end
  end

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
    puts self.dispatch_station.name
    self.intermediate_stations.each do |station|
      puts station.name
    end
    puts self.terminal_station.name
  end

  def get_iterator()
    return RouteIterator(self, -1)
  end

end