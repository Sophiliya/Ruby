class Route < ActiveRecord::Base
  # belongs_to :start, :class_name => "Station"
  # belongs_to :finish, :class_name => "Station"
  has_and_belongs_to_many :stations
  # before_create :set_stations_default
  before_validation :set_name
  # callback 

  # def name
  #   "#{@start.name} - #{@finish.name}"
  # end

  # def add_station(station)
  #   @stations.insert(-2, station)
  # end
  #
  # def delete_station(station)
  #   @stations.delete(station) unless [@start, @finish].include?(station)
  # end

  private

  def set_name
    if stations.count == 2
      name = "#{stations.first.name}-#{stations.last.name}"
    end
  end
end
