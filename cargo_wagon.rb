require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :volume

  def initialize(volume)
    @volume = volume
    super
  end
end
