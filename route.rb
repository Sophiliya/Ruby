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
    @stations.delete(station) unless @start == station || @finish == station
  end
end
