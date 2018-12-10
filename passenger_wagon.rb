class PassengerWagon < Wagon
  attr_reader :number_of_seats

  def initialize(number_of_seats)
    @number_of_seats = number_of_seats
    register_instance
  end
end
