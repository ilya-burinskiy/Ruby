class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
end
