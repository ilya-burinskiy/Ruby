# frozen_string_literal: true
require_relative 'instances_keeper.rb'
require_relative 'instances_counter.rb'

class Station

  include InstancesCounter
  include InstancesKeeper

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []

    add_instance(name, self)
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
    instances
  end
end
