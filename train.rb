require_relative 'manufacturer_company'
require_relative 'instance_counter'
require_relative 'validator'

class Train
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include ManufacturerCompany
  include Validator

  attr_reader :number, :current_speed, :current_station, :route, :wagons

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number)
    # valid?(number)
    @number = number
    @current_speed = 0
    @wagons = []
    register_instance
  end

  def increase_speed
    @current_speed += 10
  end

  def stop
    @current_speed = 0
  end

  def hitching(wagon)
    @wagons << wagon if attachable?(wagon)
  end

  def detaching(wagon)
    @wagons.delete(wagon) if attachable?(wagon)
  end

  def assign_route(route)
    @route = route
    @route.stations.first.get_train(self)
    @current_station = @route.stations.first
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless @current_station == @route.stations.last
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] unless @current_station == @route.stations.first
  end

  def move_forward
    departing('forward') if next_station
  end

  def move_back
    departing('back') if previous_station
  end

  # protected

  def departing(direction)
    @current_station.send_train(self)

    case direction
    when 'forward'
      next_station.get_train(self)
      @current_station = next_station
    when 'back'
      previous_station.get_train(self)
      @current_station = previous_station
    end
  end

  def attachable?(wagon)
    @current_speed == 0
  end

  def get_each_wagon_with_index
    self.wagons.each.with_index(1) do |wagon, index|
      yield(wagon, index)
    end
  end
end
