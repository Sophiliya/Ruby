require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :volume, :volume_available, :volume_occupied

  def initialize(volume)
    @volume = volume
    @volume_available = volume
    @volume_occupied = 0
    super
  end

  def occupy_volume(size)
    return if @volume_available < size 

    @volume_occupied += size
    @volume_available -= size
  end
end
