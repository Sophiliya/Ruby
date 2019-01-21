require_relative 'instance_counter'
require_relative 'validator'

class Station
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include Validator

  @@stations = []

  def self.get_each_station
    @@stations.each { |station| yield(station) }
  end

  attr_reader :name, :trains

  def self.trains_info
    @@stations.each do |station|
      puts "#{station.name}:"
      station.get_each_train do |train|
        puts "#{train.number} #{train.class} #{train.wagons.count}"
      end
    end
  end

  def initialize(name)
    # valid?(name)
    @name = name
    @trains = []
    register_instance
    @@stations << self
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

  def get_each_train
    self.trains.each { |train| yield(train) }
  end
end
