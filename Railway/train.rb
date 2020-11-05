class Train
  attr_reader :number, :type
  attr_accessor :speed, :carriages, :route, :curr_station

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @carriages = 0
  end

  def increase_speed(val)
    speed += val
  end

  def brake
    speed = 0
  end

  def attach_carriage
    carriages += 1 if speed == 0
  end

  def detach_carriage
    carriages -= 1 if speed == 0
  end

  def add_route(route)
    self.route = route
    self.curr_station = self.route.dispatch_station
  end

  def next_station
    route.station_next_to(curr_station)
  end

  def prev_station
    route.station_previous_to(curr_station)
  end

  def go_forward
    raise 'Cannot go forward' if next_station.nil?

    self.curr_station = next_station
  end

  def go_back
    raise 'Cannot go back' if prev_station.nil?

    self.curr_station = prev_station
  end
end
