require_relative 'instance_counter'
require_relative 'validator'

class Route
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include Validator

  attr_reader :stations

  @@routes = []

  def self.all
    @@routes
  end

  def self.show_routes_names
    @@routes.each.with_index(1) { |route, index| puts "#{index}. #{route.name}" }
  end

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
    @@routes << self
    register_instance
  end

  def name
    "#{@start.name} - #{@finish.name}"
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless [@start, @finish].include?(station)
  end
end
