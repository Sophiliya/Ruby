class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def trains(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :stations

  def initialize(start, finish)
    @start = start  # class Station
    @finish = finish
    @stations = [@start, @finish]
  end

  def name
    "#{@start.name} - #{@finish.name}"
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless @stations.first == station or @stations.last == station
  end
end

class Train
  attr_reader :number, :type, :current_speed, :wagons_count, :current_station, :route

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @current_speed = 0
    @route = nil
    @current_station = nil
  end

  def increase_speed
    @current_speed += 10
  end

  def stop
    @current_speed = 0
  end

  def hitching
    @wagons_count += 1 if @current_speed == 0
  end

  def detaching
    @wagons_count -= 1 if @current_speed == 0 && @wagons_count > 1
  end

  def get_route(route)
    @route = route
    @route.stations.first.get_train(self)
    @current_station = @route.stations.first
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless @current_station == @route.stations.last
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] unless @current_station == @route.stations.first
  end

  def move_forward
    return 0 if self.next_station == nil

    @current_station.send_train(self)
    self.next_station.get_train(self)
    @current_station = self.next_station
  end

  def move_back
    return 0 if self.previous_station == nil

    @current_station.send_train(self)
    self.previous_station.get_train(self)
    @current_station = self.previous_station
  end
end
