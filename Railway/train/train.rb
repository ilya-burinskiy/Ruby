# frozen_string_literal: true
require_relative '../instances_keeper.rb'
require_relative '../instances_counter.rb'
require_relative '../company'

class Train
  include InstancesCounter
  include InstancesKeeper
  include Company
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
    carriages << carriage if speed.zero?
  end

  def detach_carriage
    carriages.pop if speed.zero?
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

  def move_forward
    raise 'No route' if curr_station.nil?
    raise 'Cannot go forward' if next_station.nil?

    curr_station.send_train(self)
    self.curr_station = next_station
    curr_station.serve_train(self)
  end

  def move_back
    raise 'No route' if curr_station.nil?
    raise 'Cannot go back' if prev_station.nil?

    curr_station.send_train(self)
    self.curr_station = prev_station
    curr_station.serve_train(self)
  end

  def self.find(number)
    instances.fetch(number, nil)
  end

  private

  attr_writer :speed, :carriages, :route, :curr_station
end
