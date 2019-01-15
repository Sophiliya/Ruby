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

  attr_reader :instructions, :routes, :trains

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
    name ? @stations << Station.new(name) : return
    show_message('station')
  end

  def create_train
    number = get_numeric('train', 'number')
    number ? train_type = get_by_index(@types, 'type') : return

    case train_type
    when 'Cargo'
      @trains << CargoTrain.new(number)
    when 'Passenger'
      @trains << PassengerTrain.new(number)
    else # train_type = false
      return
    end

    show_message('train')
  end

  def create_route
    stations = get_stations
    return unless stations
    @routes << Route.new(stations.first, stations.last)
    show_message('route')
  end

  def get_stations
    if is_enough?(@stations, 2, 'stations')
      station_1 = get_by_index(@stations, 'station 1')
      station_1 ? station_2 = get_by_index(@stations, 'station 2') : return
      station_1 && station_2 ? [ station_1, station_2 ] : false
    else
      false
    end
  end

  def assign_route
    return unless exists?(@routes,'route') && exists?(@trains, 'train')
    train = get_by_index(@trains, 'train')
    train ? route = get_by_index(@routes, 'route') : return
    route ? train.assign_route(route) : return
    puts "Route #{route.name} was assigned to the train #{train.number}."
  end

  def create_wagon
    wagon_type = get_by_index(@types, 'type')
    wagon_type ? size = get_numeric('wagon', 'size') : return
    if size && wagon_type == 'Cargo'
      @wagons << CargoWagon.new(size)
    elsif size && wagon_type == 'Passenger'
      @wagons << PassengerWagon.new(size)
    else
      return
    end
    show_message('wagon')
  end

  def add_wagon
    exists?(@trains, 'train') ? train = get_by_index(@trains, 'train') : return
    train ? wagon_class = train.class == CargoTrain ? CargoWagon : PassengerWagon : return

    wagon = get_by_index(@wagons.select { |w| w.class == wagon_class }.uniq, 'wagon')

    wagon ? train.hitching(wagon) : return
    @wagons.delete(wagon)
    puts "Wagon was added to the train #{train.number}."
  end

  def detach_wagon
    trains_with_wagon = @trains.select { |train| train.wagons.length > 0 }
    return unless exists?(trains_with_wagon, 'train')
    train = get_by_index(trains_with_wagon, 'train')
    train ? wagon = get_by_index(train.wagons, 'wagon') : return
    wagon ? train.detaching(wagon) : return
    @wagons << wagon
    puts "Wagon was detached from the train #{train.number}."
  end

  def move_train
    trains_with_route = @trains.select { |train| train.route != nil }
    return unless exists?(trains_with_route, 'train with route')
    train = get_by_index(trains_with_route, 'train')
    train && train_movable?(train) ? train.move_forward : return
    puts "#{train.class} #{train.number} was moved."
  end

  def train_movable?(train)
    return unless train
    current_station_index = train.route.stations.index(train.current_station)
    current_station_index < train.route.stations.length - 1
  end

  def trains_at_station
    return unless exists?(@stations, 'station with trains')
    station = get_by_index(@stations, 'station')

    if station && station.trains.count > 0
      station.trains.each.with_index(1) { |t, i| puts "#{i}. #{t.class} - #{t.number}" }
    elsif station && station.trains.count == 0
      puts "No trains at the station #{station.name}"
    else
      return
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
    index_exists?(index, object_array.length) ? object_array[index - 1] : false
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
