require_relative 'station.rb'
require_relative 'wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'route.rb'

class App
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
      self.instructions.each { |k, v| puts "#{k}. #{v}" }

      puts 'Enter the command:'

      command = gets.chomp.strip.to_i

      break if command == 11 || command == 'stop'

      if index_exists?(command, (1..@instructions.length).to_a)
        execute(command)
      else
        puts 'Incorrect index of the command.'
      end

    end
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
      when 9 then stations
      when 10 then trains_at_station
    end
  end

  def create_station
    puts 'Enter the name of station: '

    station_name = gets.chomp.strip

    return p "Empty name was entered." if station_name.empty?

    @stations << Station.new(station_name)

    puts "Station '#{station_name}' was created."
  end

  def create_train
    puts 'Choose the type of the train: 1. Cargo, 2. Passenger.'

    train_type_index = gets.chomp.strip.to_i

    return p 'Incorrect index.' unless index_exists?(train_type_index, @types)

    puts 'Enter the number of train: '

    number = gets.chomp.strip

    return p "Empty number was entered." if number.empty?

    case @types[train_type_index - 1]
    when 'Cargo'
      @trains << CargoTrain.new(number)
    when 'Passenger'
      @trains << PassengerTrain.new(number)
    end

    puts "#{@types[train_type_index - 1]} train #{number} was created."
  end

  def create_route
    return p 'There is only one station.' if @stations.length < 2

    puts 'Eneter the number of first and last stations:'
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }

    station_index_1 = gets.chomp.strip.to_i
    station_index_2 = gets.chomp.strip.to_i

    return p 'Incorrect index.' unless index_exists?(station_index_1, @stations) && index_exists?(station_index_2, @stations)

    station_1 = @stations[station_index_1 - 1]
    station_2 = @stations[station_index_2 - 1]

    @routes << Route.new(station_1, station_2)

    puts "Route #{station_1.name} - #{station_2.name} was built."
  end

  def assign_route
    return p 'At first built a route and create a train.' if @routes.empty? || @trains.empty?

    train = choose_train(@trains)

    return p 'Incorrect index.' if train == 'Error'

    puts 'Choose the route by index: '

    @routes.each.with_index(1) { |route, index| puts "#{index}. #{route.name}" }

    route_index = gets.chomp.strip.to_i

    return p 'Incorrect index.' unless index_exists?(route_index, @routes)

    route = @routes[route_index-1]

    train.get_route(route)

    puts "Route #{route.name} was assigned to the train #{train.number}."
  end

  def create_wagon
    puts 'Choose wagon type: 1. Cargo  2. Passenger'

    wagon_type_index = gets.chomp.strip.to_i

    return p 'Incorrect index.' unless index_exists?(wagon_type_index, @types)

    wagon_type = @types[wagon_type_index - 1]

    puts "Enter the wagon size: "

    size = gets.chomp.strip.to_i

    return p 'Incorrect size.' unless size > 0

    wagon_type == 'Cargo' ? @wagons << CargoWagon.new(size) : @wagons << PassengerWagon.new(size)

    puts "#{wagon_type} wagon was created"
  end

  def add_wagon
    return p 'At first create a train and wagon.' if @trains.empty? || @wagons.empty?

    train = choose_train(@trains)

    return p 'Incorrect index.' if train == 'Error'

    wagon_class = train.class == CargoTrain ? CargoWagon : PassengerWagon

    wagons = @wagons.select { |wagon| wagon.class == wagon_class }.uniq

    return p "There is no #{wagon_class}" if wagons.empty?

    wagon = choose_wagon(wagon_class, wagons)

    return p 'Incorrect index.' if wagon == 'Error'

    train.hitching(wagon)

    @wagons.delete(wagon)

    puts "Wagon was added to the train #{train.number}."
  end

  def detach_wagon
    return p 'At first create a train and attach wagons.' unless @trains.inject(0) { |sum, train| sum += train.wagons.length } > 0

    trains_with_wagon = @trains.select { |train| train.wagons.length > 0 }

    train = choose_train(trains_with_wagon)

    return p 'Incorrect index.' if train == 'Error'

    wagon_class = train.class == CargoTrain ? CargoWagon : PassengerWagon

    return p "There is no #{wagon_class}" if train.wagons.empty?

    wagon = choose_wagon(wagon_class, train.wagons)

    return p 'Incorrect index.' if wagon == 'Error'

    train.detaching(wagon)

    @wagons << wagon

    puts "Wagon was detached from the train #{train.number}."
  end

  def move_train
    trains_with_route = @trains.select { |train| train.route != nil }

    return p 'At first assign route to the train.' if trains_with_route.empty?

    train = choose_train(trains_with_route)

    return p 'Incorrect index.' if train == 'Error'

    puts "Current station: #{train.current_station.name}."

    puts "Stations of the route: #{train.route.stations.map(&:name)}."

    puts 'Choose the direction: 1. forward, 2. back.'

    directions = ['forward', 'back']

    direction_index = gets.chomp.strip.to_i

    return p 'Incorrect index.' unless index_exists?(direction_index, directions)

    current_station_index = train.route.stations.index(train.current_station)

    no_move_forward = direction_index == 1 && current_station_index == train.route.stations.length - 1
    no_move_back = direction_index == 2 && current_station_index == 0

    return p 'Train cannot move to this direction.' if no_move_forward || no_move_back

    case directions[direction_index - 1]
      when 'forward' then train.move_forward
      when 'back' then train.move_back
    end

    puts "#{train.class} #{train.number} was moved #{directions[direction_index - 1]}."
  end

  def stations
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def trains_at_station
    return p 'No station was created.' if @stations.empty?

    puts 'Choose the station by index: '

    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }

    station_index = gets.chomp.strip.to_i

    return p 'Incorrect index.' unless index_exists?(station_index, @stations)

    station = @stations[station_index - 1]

    return p "There are no trains at the station #{station.name}." if station.trains.empty?

    station.trains.each.with_index(1) { |train, index| puts "#{index}. #{train.class} - #{train.number}" }
  end

  private

  def index_exists?(number, array)
    indexes = (1..array.length).to_a
    number > 0 && indexes.include?(number)
  end

  def choose_train(trains)
    puts 'Choose the train by index: '

    trains.each.with_index(1) { |train, index| puts "#{index}. #{train.number} - #{train.class}" }

    train_index = gets.chomp.strip.to_i

    return 'Error' unless index_exists?(train_index, @trains)

    train = trains[train_index-1]
  end

  def choose_wagon(wagon_class, wagons)
    puts 'Choose the wagon volume/seats:'

    if wagon_class == CargoWagon
      wagons.each.with_index(1) { |wagon, index| puts "#{index}. #{wagon.volume}"}
    else
      wagons.each.with_index(1) { |wagon, index| puts "#{index}. #{wagon.number_of_seats}"}
    end

    wagon_index = gets.chomp.strip.to_i
    return 'Error' unless index_exists?(wagon_index, wagons)
    wagon = wagons[wagon_index - 1]
  end
end
