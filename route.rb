require_relative 'instance_counter'
require_relative 'validator'

class Route
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include Validator

  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
    register_instance
  end

  def name
    "#{@start.name} - #{@finish.name}"
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless @start == station || @finish == station
  end
end
