class PassengerWagon < Wagon
  attr_reader :number, :number_of_seats

  def initialize(number, number_of_seats)
    @number = number
    @number_of_seats = number_of_seats
  end
end
