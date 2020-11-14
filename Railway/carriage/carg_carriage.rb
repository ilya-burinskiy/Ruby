# frozen_string_literal: true

require_relative 'carriage'

class CargCarriage < Carriage
  attr_reader :capacity, :occupied_capacity

  def initialize(capacity)
    super(:carg)
    @capacity = capacity
    @occupied_space = 0.0
  end

  def load_carg(val)
    raise 'Not enough space' if occupied_space == capacity

    self.occupied_space += val
  end

  def free_space
    capacity - occupied_space
  end

  private

  attr_writer :capacity, :occupied_capacity
end
