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

  attr_reader :instructions, :routes, :trains, :stations

  def initialize
    @stations = Station.all
    @trains = Train.all
    @routes = Route.all
    @wagons = Wagon.all
    @types = %w(Cargo Passenger)
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
      user_choice = get_user_choice

      break if user_choice == 11

      index_exists?(user_choice, @instructions.length) ? perform(user_choice) : start
    end
  end

  def show_menu
    @instructions.each { |k, v| puts "#{k}. #{v}" }
  end

  def get_user_choice
    puts 'Choose the option:'
    gets.chomp.strip.to_i
  end

  def perform(user_choice)
    case user_choice
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
    name ? Station.new(name) : return
    show_message('station')
  end

  def create_train
    number = get_name('train')
    type   = get_by_index(@types, 'type') if number

    case type
    when 'Cargo'
      CargoTrain.new(number)
    when 'Passenger'
      PassengerTrain.new(number)
    else
      return
    end

    show_message('train')
  end

  def create_route
    stations = get_stations
    stations ? Route.new(stations.first, stations.last) : return
    show_message('route')
  end

  def get_stations
    station_1 = get_by_index(@stations, 'name', 1)
    station_2 = get_by_index(@stations, 'name', 2)

    [station_1, station_2] if (station_1 && station_2) && (station_1 != station_2)
  end

  def assign_route
    train = get_by_index(@trains, 'number')
    route = get_by_index(@routes, 'name')
    return unless train && route

    train.assign_route(route)
    puts "Route #{route.name} was assigned to the train #{train.number}."
  end

  def create_wagon
    type = get_by_index(@types, 'type')
    size = get_numeric('wagon', 'volume/number of seats')
    return unless size

    case type
    when 'Cargo'
      CargoWagon.new(size)
    when 'Passenger'
      PassengerWagon.new(size)
    else
      return
    end

    show_message('wagon')
  end

  def add_wagon
    train = get_by_index(@trains, 'number')
    wagon = get_wagon(train.class)
    return unless train && wagon

    train.hitching(wagon)
    puts "Wagon was added to the train #{train.number}."
  end

  def get_wagon(train_class)
    return unless train_class

    wagon_class = train_class == CargoTrain ? CargoWagon : PassengerWagon
    wagons_available = @wagons.select { |w| w.class == wagon_class && w.attached == 0 }.uniq
    get_by_index(wagons_available, 'volume')
  end

  def detach_wagon
    train = get_by_index(trains_with_wagons, 'number')
    wagon = get_by_index(train.wagons, 'volume')
    return unless train && wagon

    train.detaching(wagon)
    puts "Wagon was detached from the train #{train.number}."
  end

  def trains_with_wagons
    @trains.reject { |train| train.wagons.empty? }
  end

  def move_train
    train = get_by_index(trains_with_route, 'number')
    train && train_movable?(train) ? train.move_forward : return
    puts "#{train.class} #{train.number} was moved."
  end

  def trains_with_route
    @trains.select { |train| train.route != nil }
  end

  def train_movable?(train)
    return unless train

    current_station_index = train.route.stations.index(train.current_station)
    current_station_index < train.route.stations.length - 1
  end

  def trains_at_station
    station = get_by_index(@stations, 'name')
    station.show_trains_list if station
  end

  def get_name(object)
    puts "Enter the name/number of #{object}: "
    name = gets.chomp.strip
    name if valid?(name)
  end

  def get_numeric(object_name, parameter_name)
    puts "Enter the #{parameter_name} of #{object_name}: "
    number = gets.chomp.strip
    number if number_valid?(number)
  end

  def get_by_index(object_array, attribute_name, number = '')
    return if object_array.empty?
    show(object_array, attribute_name)
    object_name = attribute_name == 'type' ? attribute_name : object_array.first.class
    puts "Choose #{object_name} #{number} by index:"
    index = gets.chomp.strip.to_i
    object_array[index - 1] if index_exists?(index, object_array.length)
  end

  def show(object_array, attribute_name)
    if attribute_name == 'type'
      object_array.each.with_index(1) { |type, index| puts "#{index}. #{type}" }
    else
      object_array.first.class.show_instances_list(object_array, attribute_name)
    end
  end

  def show_message(object)
    puts "#{object.capitalize} was created."
  end
end
