require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

s1 = Station.new('S1')
s2 = Station.new('S2')

t1 = PassengerTrain.new('P12')
t2 = PassengerTrain.new('P13')
t3 = CargoTrain.new('C15')

s1.get_train(t1)
s1.get_train(t3)
s2.get_train(t2)

wagons = []
4.times { wagons << PassengerWagon.new(rand(50)) }
3.times { wagons << CargoWagon.new(rand(25)) }

wagons.select { |w| w.class == PassengerWagon }.each { |w| rand(t1, t2).hitching(w) }
wagons.select { |w| w.class == CargoWagon }.each { |w| t3.hitching(w) }

trains_info = proc do |trains|
  trains.each do |train|
    puts "#{train.number}, #{train.class}, #{train.wagons.count}"
  end
end

stations_train_info = proc do |stations|
  stations.each do |station|
    puts "#{station.name} info:"
    trains_info.call(station.trains)
  end
end

stations_train_info.call(Station.all_stations)

wagons_info = proc do |wagons|
  wagons.each.with_index(1) do |wagon, index|
    case wagon.class.to_s
    when 'PassengerWagon'
      "#{index}. #{wagon.seats_available}, #{wagon.seats_occupied}"
    when 'CargoWagon'
      "#{index}. #{wagon.volume_available}, #{wagon.volume_occupied}"
    end
  end
end

trains_wagon_info = proc do |trains|
  trains.each do |train|
    puts "Train #{train.number} wagons info:"
    wagons_info.call(train.wagons)
  end
end

stations_train_wagons_info = proc do |stations|
  stations.each do |station|
    puts "#{station.name} info:"
    trains_wagon_info.call(station.trains)
  end
end
