class Train
  attr_reader :number, :current_speed, :current_station, :route, :wagons

  def initialize(number)
    @number = number
    @current_speed = 0
    @wagons = []
  end

  def increase_speed
    @current_speed += 10
  end

  def stop
    @current_speed = 0
  end

  def hitching(wagon)
    @wagons << wagon if attachable?(wagon)
  end

  def detaching(wagon)
    @wagons.delete(wagon) if attachable?(wagon)
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
    departing('forward') if next_station
  end

  def move_back
    departing('back') if previous_station
  end

  protected

  def departing(direction)
    @current_station.send_train(self)

    case direction
    when 'forward'
      next_station.get_train(self)
      @current_station = next_station
    when 'back'
      previous_station.get_train(self)
      @current_station = previous_station
    end
  end

  def attachable?(wagon)
    @current_speed == 0 
  end
end
