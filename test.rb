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

w1 = PassengerWagon.new(50)
w2 = PassengerWagon.new(45)
w3 = PassengerWagon.new(50)
w4 = PassengerWagon.new(45)
w5 = CargoWagon.new(10)
w6 = CargoWagon.new(15)

t1.hitching(w1)
t1.hitching(w2)
t1.hitching(w3)
t2.hitching(w4)
t3.hitching(w5)
t3.hitching(w6)

object_info = Proc.new do |number, type, count|
  puts "#{number}, #{type}, #{count}"
end

Station.get_each_station do |station|
  puts "Station #{station.name}: train number, type, number of wagons."
  station.get_each_train do |train|
    object_info.call(train.number, train.class, train.wagons.count)
  end
end

Station.get_each_station do |station|
  puts "Station #{station.name}:"

  station.get_each_train do |train|
    puts "Train #{train.number}: wagon number, type, available & occupied volume."

    train.get_each_wagon_with_index do |wagon, index|
      volume_info =
      case wagon.class.to_s
      when 'PassengerWagon'
        "#{wagon.seats_available}, #{wagon.seats_occupied}"
      when 'CargoWagon'
        "#{wagon.volume_available}, #{wagon.volume_occupied}"
      end

      object_info.call(index, wagon.class, volume_info)
    end
  end
end
