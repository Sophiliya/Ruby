require_relative 'manufacturer_company'
require_relative 'instance_counter'
require_relative 'validator'

class Wagon
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  include ManufacturerCompany
  include Validator

  attr_reader :volume

  def initialize(volume)
    # number_valid?(volume)
    @volume = volume
    register_instance
  end
end
