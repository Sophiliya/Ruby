class Station
  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self 
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
