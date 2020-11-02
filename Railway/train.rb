class Train

  attr_reader :number
  attr_reader :type
  
  attr_accessor :speed
  attr_accessor :carriages
  attr_accessor :route_it

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0;
    @carriages = 0;
  end

  def increase_speed(val)
    self.speed += val
  end

  def brake()
    self.speed = 0
  end

  def attach_carriage()
    if self.speed == 0
      self.carriages += 1
    end
  end

  def detach_carriage()
    if self.speed == 0
      self.carriages -= 1
    end
  end

  def add_route(route)
    self.route_it = route.get_iterator()
  end

  def forward()
    begin
      self.route_it.forward()
    rescue Exception => e
      puts "Cannot go forward"
    end
  end

  def back()
    begin
      self.route_it.back()
    rescue Exception => e
      puts "Cannot go back"
    end
  end

  def prev()
    return self.route_it.prev()
  end

  def curr()
    return self.route_it.curr()
  end

  def next()
    return self.route_it.next()
  end

end