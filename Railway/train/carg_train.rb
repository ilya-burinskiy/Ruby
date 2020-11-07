require_relative 'train.rb'

class CargTrain < Train

  def initialize(number)
    super(number, :carg)
  end
end