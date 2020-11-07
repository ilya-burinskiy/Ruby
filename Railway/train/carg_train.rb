# frozen_string_literal: true

require_relative 'train'

class CargTrain < Train
  def initialize(number)
    super(number, :carg)
  end
end
