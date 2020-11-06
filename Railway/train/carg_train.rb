require_relative 'train.rb'

class CargTrain < Train

  def initialize(number)
    super(number, :carg)
  end
  
  def attach_carriage(carriage)
    raise "Cannot attach passanger carriage. Train is passenger" if carriage.type == :passanger
    super
  end

end