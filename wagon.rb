require 'pry'

require_relative 'manufacturer_company'
require_relative 'instance_counter'
require_relative 'validator'

class Wagon
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include ManufacturerCompany
  include Validator

  attr_reader :volume
  attr_accessor :attached

  @@wagons = []

  def self.all
    @@wagons
  end

  def self.show_wagons_list(wagons = nil)
    wagons_to_show = wagons ? wagons : @@wagons
    wagons_to_show.each.with_index(1) do |wagon, index|
      puts "#{index}. #{wagon.volume} - #{wagon.class}"
    end
  end

  def self.read_file
    File.open('wagons.txt') do |f|
      f.each { |line| puts line }
    end
  end

  def initialize(volume)
    # number_valid?(volume)
    @volume = volume
    @attached = 0
    @@wagons << self
    register_instance
    write_to_file
  end

  def write_to_file
    File.open('wagons.txt', 'a') do |f|
      i ||= 1
      f.puts "#{i += 1}. #{self.class} (#{Time.now})"
    end
  end
end
