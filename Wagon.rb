class Wagon
  attr_reader :type, :volume

  def initialize(type, volume)
    @type = type
    @volume = volume
  end
end
