class Train

  attr_reader :number, :type
  attr_accessor :speed, :carriages, :route 
  attr_accessor :curr_station, :prev_station, :next_station

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
    self.prev_station = self.route.station_previous_to(self.curr_station)
    self.next_station = self.route.station_next_to(self.curr_station)
  end

  def go_forward
    if self.next_station != nil
      self.prev_station = self.curr_station
      self.curr_station = self.next_station
      self.next_station = route.station_next_to(self.next_station)
    else
      raise Exception.new "Cannot go forward"
    end
  end

  def go_back
    if self.prev_station != nil
      self.next_station = self.curr_station
      self.curr_station = self.prev_station
      self.prev_station = route.station_previous_to(self.prev_station)
    else
      raise Exception.new "Cannot go back"
    end
  end

end