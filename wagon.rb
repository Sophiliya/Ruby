require_relative 'manufacturer_company.rb'
require_relative 'instance_counter.rb'

class Wagon
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include ManufacturerCompany

  @@wagons = []

  def self.all
    @@wagons
  end
end
