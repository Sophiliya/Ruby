class Station
  def initialize(station)
    @station = station
  end

  def name
    @station
  end
end

class Route
  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def name
    @start.name + ' - ' + @finish.name
  end

  def stations
    [@start.name, @finish.name]
  end
end

class Train
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def go(speed)
    @speed = speed if speed.class == Integer
  end

  def current_speed
    @speed
  end

  def stop
    @speed = 0
  end

  def length
    @wagons
  end

  def hitching
    @wagons += 1 if @speed == 0
  end

  def detaching
    @wagons -= 1 if @speed == 0 && @wagons > 1
  end

end
