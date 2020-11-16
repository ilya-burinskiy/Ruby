# frozen_string_literal: true

require_relative 'instances_counter'
require_relative 'validation'

class Station
  include InstancesCounter
  include Validation

  @@stations = {}
  STATION_NAME_FORMAT = /^[A-Z][a-z]*(?:-[A-Z])?[a-z]*$/.freeze

  attr_reader :name, :trains
  validate :name, :format, STATION_NAME_FORMAT

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
    validate!
    register_instance
  end

  def serve_train(train)
    trains << train
  end

  def trains_by_type(train_type)
    trains.select { |train| train.type == train_type }
  end

  def send_train(train)
    trains.delete(train)
  end

  def train_to_block
    trains.each { |train| yield(train) }
  end

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations.fetch(name, nil)
  end

end
