class Station
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

class Route
  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start.name, @finish.name]
  end

  def name
    "#{@start.name} - #{@finish.name}"
  end

  def stations
    @stations
  end
end

class Train
  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
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

  def wagons_count
    @wagons_count
  end

  def hitching
    @wagons_count += 1 if @speed == 0
  end

  def detaching
    @wagons_count -= 1 if @speed == 0 && @wagons > 1
  end

end 
