class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def list_of_trains(type)
    @trains.select { |train| train.type == type }.map(&:number)
  end

  def send_train(train)
    if @trains.include? (train)
      @trains.delete(train)
    end
  end
end

class Route
  def initialize(start, finish)
    @start = start  # class Station
    @finish = finish
    @stations = [@start, @finish]
  end

  def name
    "#{@start.name} - #{@finish.name}"
  end

  def list_of_stations
    @stations.map { |station| station.name }
  end

  def stations
    @stations
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.include? (station)
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

  def move(speed)
    @current_speed = speed if speed.class == Integer
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
