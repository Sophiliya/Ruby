class CargoWagon < Wagon
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end
