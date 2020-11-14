# frozen_string_literal: true

require_relative '../instances_counter'
require_relative '../company'

class Train
  include InstancesCounter
  include Company

  attr_reader :number, :type, :speed, :carriages, :route, :curr_station

  @@trains = {}
  TRAIN_NUMBER_FORMAT = /\w{3}-?\w{2}/.freeze

  def initialize(number, type)
    validate!(number)
    @number = number
    @type = type
    @speed = 0
    @carriages = []

    @@trains[number] = self
    register_instance
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

  def carriage_to_block
    carriages.each { |carriage| yield(carriage) }
  end

  def find_carriage(carriage_idx)
    carriages.fetch(carriage_idx, nil)
  end

  def carriage_exist?(carriage_idx)
    raise "Carriage with index #{carriage_idx} does not exist" if find_carriage(carriage_idx).nil?

    true
  end

  def self.find(number)
    @@trains.fetch(number, nil)
  end

  def self.all
    @@trains
  end

  protected

  def validate!(number)
    raise 'Invalid train number' if number !~ TRAIN_NUMBER_FORMAT
  end

  private

  attr_writer :speed, :carriages, :route, :curr_station
end
