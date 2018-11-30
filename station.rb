class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def trains(type)
    @trains.select { |train| train.class == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
