class Train
  attr_reader :number, :type, :speed, :carriages, :route, :curr_station

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @carriages = []
  end

  def increase_speed(val)
    self.speed += val
  end

  def brake
    self.speed = 0
  end

  def attach_carriage(carriage)
    carriages << carriage if speed == 0
  end

  def detach_carriage
    carriages.pop if speed == 0
  end

  def add_route(route)
    self.route = route
    self.curr_station = self.route.dispatch_station
    curr_station.serve_train(self)
  end

  def next_station
    route.station_next_to(curr_station)
  end

  def prev_station
    route.station_previous_to(curr_station)
  end

  def go_forward
    raise 'Cannot go forward' if next_station.nil?

    curr_station.send_train(self)
    self.curr_station = next_station
    curr_station.serve_train(self)
  end

  def go_back
    raise 'Cannot go back' if prev_station.nil?

    curr_station.send_train(self)
    self.curr_station = prev_station
    curr_station.serve_train(self)
  end

  private
  attr_writer :speed, :carriages, :route, :curr_station
end