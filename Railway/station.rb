# frozen_string_literal: true

require_relative 'instances_keeper'
require_relative 'instances_counter'

class Station
  include InstancesCounter

  attr_reader :name, :trains

  @@stations = {}

  def initialize(name)
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

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations.fetch(name, nil)
  end
end
