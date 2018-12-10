require_relative 'instance_counter.rb'

class Station
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
  end

  def get_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.class == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
