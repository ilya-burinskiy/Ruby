class Station

  attr_reader :name
  attr_reader :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def serve_train(train)
    self.trains << train
  end

  def trains_by_type(train_type)
    res = []
    self.trains.each do |train|
      if train.type == train_type
        res << train
      end
    end
    return res
  end

  def send_train(train)
    self.trains.delete(train)
  end

end