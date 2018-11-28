class PassengerTrain
  attr_reader :number, :current_speed, :current_station, :route, :wagons

  def initialize(number)
    @number = number
    @type = type
    @current_speed = 0
    @route = nil
    @current_station = nil
    @wagons = []
  end

  def increase_speed
    @current_speed += 10
  end

  def stop
    @current_speed = 0
  end

  def hitching(wagon)
    @wagon = wagon
    @action = 'hitch'

    hitch_or_detach
  end

  def detaching(wagon)
    @wagon = wagon
    @action = 'detach'

    hitch_or_detach
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
    @direction = 'forward'

    departing if next_station
  end

  def move_back
    @direction = 'back'

    departing if previous_station
  end

  private
  # добавила в private так как важно сначало проверить может ли поезд поехать вперед или назад
  # поэтому без проверки на следующую станцию вызывать метод departing нельзя
  # иначе вернет ошибку если поезд на первой станции хочет назад
  # или на последней вперед поехать

  def departing
    @current_station.send_train(self)

    if @direction == 'forward'
      next_station.get_train(self)
      @current_station = next_station
    else
      previous_station.get_train(self)
      @current_station = previous_station
    end
  end

  def hitch_or_detach
    return unless @current_speed == 0

    if @action == 'hitch' && @wagon.type == 'Passenger'
      @wagons << @wagon
    elsif @action == 'detach'
      @wagons.delete(@wagon)
    end
  end
end
