class CargoWagon < Wagon
  attr_reader :number, :volume

  def initialize(number, volume)
    @number = number
    @volume = volume
  end
end
