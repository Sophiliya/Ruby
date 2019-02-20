class Station < ActiveRecord::Base
  has_and_belongs_to_many :routes
  has_many :trains

  validates :name, presence: true

  # def get_train(train)
  #   @trains << train
  # end
  #
  # def send_train(train)
  #   @trains.delete(train)
  # end
  #
  # def show_trains_list
  #   return puts 'No trains at the station.' if @trains.empty?
  #
  #   @trains.each.with_index(1) do |train, index|
  #     puts "#{index}. #{@name} - #{self.class}"
  #   end
  # end
end
