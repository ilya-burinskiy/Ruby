# frozen_string_literal: true

require_relative 'instances_counter'

class Station
  include InstancesCounter

  attr_reader :name, :trains

  @@stations = {}
  STATION_NAME_FORMAT = /^[A-Z][a-z]*(?:-[A-Z])?[a-z]*$/.freeze

  def initialize(name)
    validate!(name)

    @name = name
    @trains = []
    @@stations[name] = self
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

  protected

  def validate!(name)
    raise 'Invalid station name' if name !~ STATION_NAME_FORMAT
  end
end
