# po4emu s = Station.new(123) empty?
require_relative 'station'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'validator'

class App
  include Validator

  attr_reader :instructions

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    @types = ['Cargo', 'Passenger']
    @instructions = { 1 => 'Create station', 2 => 'Create train', 3 => 'Create route',
                      4 => 'Assign route to train', 5 => 'Create wagon',
                      6 => 'Add wagon to train', 7 => 'Detach wagon from train',
                      8 => 'Move train forward/back',
                      9 => 'Stations list', 10 => 'List of trains on the station',
                      11 => 'Exit' }
  end

  def start
    loop do
      show_menu
      command = take_command

      break if command == 11

      index_exists?(command, @instructions.length) ? execute(command) : start
    end
  end

  private

  def show_menu
    @instructions.each { |k, v| puts "#{k}. #{v}" }
  end

  def take_command
    puts 'Enter the command:'
    gets.chomp.strip.to_i
  end

  def execute(command)
    case command
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then assign_route
      when 5 then create_wagon
      when 6 then add_wagon
      when 7 then detach_wagon
      when 8 then move_train
      when 9 then show(@stations, 'name')
      when 10 then trains_at_station
    end
  end

  def create_station
    name = get_name('station')
    @stations << Station.new(name)
    show_message('station')
  end

  def create_train
    number = get_numeric('train', 'number')
    train_type = get_by_index(@types, 'type')

    if train_type == 'Cargo'
      @trains << CargoTrain.new(number)
    else
      @trains << PassengerTrain.new(number)
    end

    show_message('train')
  end

  def create_route
    stations = get_stations
    @routes << Route.new(stations.first, stations.last)
    show_message('route')
  end

  def get_stations
    return p 'There are not enough stations.' if @stations.length < 2
    station_1 = get_by_index(@stations, 'station 1')
    station_2 = get_by_index(@stations, 'station 2')
    return p 'Choose different stations.' if station_1 == station_2
    [ station_1, station_2 ]
  end

  def assign_route
    return p 'There are no trains or routes.' if @trains.empty? || @routes.empty?
    train = get_by_index(@trains, 'train')
    route = get_by_index(@routes, 'route')
    train.assign_route(route)
    puts "Route #{route.name} was assigned to the train #{train.number}."
  end

  def create_wagon
    wagon_type = get_by_index(@types, 'type')
    size = get_numeric('wagon', 'size')
    wagon_type == 'Cargo' ? @wagons << CargoWagon.new(size) : @wagons << PassengerWagon.new(size)
    show_message('wagon')
  end

  def add_wagon
    return p 'No trains exist.' if @trains.empty?
    train = get_by_index(@trains, 'train')
    wagon_class = train.class == CargoTrain ? CargoWagon : PassengerWagon

    wagons = @wagons.select { |wagon| wagon.class == wagon_class }.uniq
    wagon = get_by_index(wagons, 'wagon')

    train.hitching(wagon)
    @wagons.delete(wagon)

    puts "Wagon was added to the train #{train.number}."
  end

  def detach_wagon
    return p 'No trains exist.' if @trains.empty?
    trains_with_wagon = @trains.select { |train| train.wagons.length > 0 }
    train = get_by_index(trains_with_wagon, 'train')
    wagon = get_by_index(train.wagons, 'wagon')

    train.detaching(wagon)
    @wagons << wagon
    puts "Wagon was detached from the train #{train.number}."
  end

  def move_train
    return p 'No trains exist.' if @trains.empty?
    trains_with_route = @trains.select { |train| train.route != nil }
    return p 'There are no trains with route.' if trains_with_route.empty?
    train = get_by_index(trains_with_route, 'train')
    train.move_forward if train_movable?(train)
    puts "#{train.class} #{train.number} was moved."
  end

  def train_movable?(train)
    current_station_index = train.route.stations.index(train.current_station)
    current_station_index < train.route.stations.length - 1
  end

  def trains_at_station
    return p 'There is no station exists.' if @stations.empty?
    station = get_by_index(@stations, 'station')

    if station.trains.empty?
      puts "There are no trains at the station #{station.name}."
    else
      station.trains.each.with_index(1) { |train, index| puts "#{index}. #{train.class} - #{train.number}" }
    end
  end

  def get_name(object)
    puts "Enter the name of #{object}: "
    name = gets.chomp.strip
    name if valid?(name)
  end

  def get_numeric(object_name, parameter_name)
    puts "Enter the #{parameter_name} of #{object_name}: "
    number = gets.chomp.strip
    number if number_valid?(number)
  end

  def get_by_index(object_array, object_name)
    show(object_array, object_name)
    puts "Choose #{object_name} by index:"
    index = gets.chomp.strip.to_i
    index_exists?(index, object_array.length) ? object_array[index - 1] : start
  end

  def show(object_array, object_name)
    case object_name
    when 'type'
      object_array.each.with_index(1) { |type, index| puts "#{index}. #{type}" }
    when 'train'
      object_array.each.with_index(1) { |train, index| puts "#{index}. #{train.number}" }
    when 'wagon'
      object_array.each.with_index(1) { |wagon, index| puts "#{index}. #{wagon.volume}" }
    else # station, route
      object_array.each.with_index(1) { |object, index| puts "#{index}. #{object.name}" }
    end
  end

  def show_message(object)
    puts "#{object.capitalize} was created."
  end
end
