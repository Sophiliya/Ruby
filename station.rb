require_relative 'instance_counter'
require_relative 'validator'

class Station
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include Validator

  @@stations = []

  def self.all
    @@stations
  end

  def self.show_stations_names
    @@stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def self.read_file
    File.open('stations.txt') do |f|
      f.each { |line| puts line }
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    # valid?(name)
    @name = name
    @trains = []
    register_instance
    @@stations << self
    write_to_file
  end

  def get_train(train)
    @trains << train
  end

  # def trains_by_type(type)
  #   @trains.select { |train| train.class == type }
  # end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains_list
    return puts 'No trains at the station.' if @trains.empty?

    @trains.each.with_index(1) do |train, index|
      puts "#{index}. #{@name} - #{self.class}"
    end
  end

  def write_to_file
    File.open('stations.txt', 'a+') do |f|
      f.puts "#{@@stations.count}. #{@name} (#{Time.now})"
    end
  end
end
