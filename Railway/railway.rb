class Railway
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = {}
    @trains = {}
    @routes = {}
  end

  def show_commands(commands)
    commands.each do |command|
      puts command
    end
  end

  def create_station(station_name)
    if station_exist?(station_name)
      raise "Station already exist"
    end
    self.stations[station_name] = Station.new(station_name)
  end

  def create_train(train_number, train_type)
    if train_exist?(train_number) 
      raise "Train already exist"
    end
    if train_type == 'carg'
      self.trains[train_number] = CargTrain.new(train_number)
    elsif train_type == 'passenger'
      self.trains[train_number] = PassengerTrain.new(train_number)
    else
      raise "Unknown train type"
    end
  end

  def create_route(route_name, dispatch_station_name, terminal_station_name)
    if route_exist?(route_name)
      raise "Route already exist"
    end
    if !station_exist?(dispatch_station_name) 
      raise "Such dispatch station doesn't exist"
    end
    if !station_exist?(terminal_station_name)
      raise "Such terminal station doesn't exist"
    end
    self.routes[route_name] = Route.new(Station.new(dispatch_station_name),
                                        Station.new(terminal_station_name))
  end

  def add_station_to_route(route_name, station_name)
    if !route_exist?(route_name)
      raise "Such route name doesn't exist"
    end
    if !station_exist?(station_name)
      raise "Such stations doesn't exist"
    end
    routes[route_name].add_station(stations[station_name])
  end

  def remove_station_from_route(route_name, station_name)
    if !route_exist?(route_name)
      raise "Such route name doesn't exist"
    end
    if !station_exist?(station_name)
      raise "Such stations doesn't exist"
    end
    routes[route_name].remove_station(stations[station_name])
  end

  def add_route_to_train(route_name, train_number)
    if !route_exist?(route_name)
      raise "Such route name doesn't exist"
    end
    if !train_exist?(train_number)
      raise "Such train doesn't exist"
    end
    trains[train_number].add_route(routes[route_name])
  end

  def attach_carriage(train_number)
    if !train_exist?(train_number)
      raise "Such train doesn't exist"
    end
    if trains[train_number].type == :carg
      trains[train_number].attach_carriage(CargCarriage.new)
    else
      trains[train_number].attach_carriage(PassengerCarriage.new)
    end
  end

  def detach_carriage(train_number)
    if !train_exist?(train_number)
      raise "Such train doesn't exist"
    end
      trains[train_number].detach_carriage
    end
  end

  def move_train_forward(train_number)
    if !train_exist?(trains, train_number)
      raise "Such train doesn't exist"
    end
  end

  def move_train_back(train_number)
    if !train_exist?(train_number)
      raise "Such train doesn't exist"
    end
  end

  def route_exist?(route_name)
    routes.key?(route_name)
  end

  def station_exist?(station_name)
    stations.key?(station_name)
  end

  def train_exist?(train_number)
    trains.key?(train_number)
  end

  private
  attr_writer :stations, :trains, :routes
end