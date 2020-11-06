require_relative 'train.rb'

class PassengerTrain < Train
  def initialize(number)
    super(number, :passanger)
  end
  
  def attach_carriage(carriage)
    raise "Cannot attach cargo carriage. Train is passenger" if carriage.type == :carg
    super
  end
end