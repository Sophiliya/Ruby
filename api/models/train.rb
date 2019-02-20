class Train < ActiveRecord::Base
  belongs_to :station
  has_one :route

  validates :number, presence: true
  validates :train_type, presence: true

  def current_speed
    @current_speed ||= 0
  end


  def increase_speed
    @current_speed += 10
  end

  def stop
    @current_speed = 0
  end

  def hook(wagon)
    @wagons << wagon if wagon_attachable?
    wagon.attached = 1
  end

  def unhook(wagon)
    @wagons.delete(wagon) if wagon_attachable?
    wagon.attached = 0
  end

  def assign_route(route)
    @route = route
    @route.stations.first.get_train(self)
    @current_station = @route.stations.first
    write_to_file
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] unless @current_station == @route.stations.last
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] unless @current_station == @route.stations.first
  end

  def move_forward
    departing('forward') if next_station
    write_to_file
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

  def wagon_attachable?
    @current_speed.zero?
  end

  def get_each_wagon_with_index
    @wagons.each.with_index(1) do |wagon, index|
      yield(wagon, index)
    end
  end
end
