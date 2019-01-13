require_relative 'instance_counter'
require_relative 'validator'

class Station
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include Validator

  attr_reader :name, :trains

  def initialize(name)
    valid?(name)
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
