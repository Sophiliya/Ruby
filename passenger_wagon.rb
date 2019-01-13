require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :number_of_seats

  def initialize(number_of_seats)
    @number_of_seats = number_of_seats
    super
  end
end
