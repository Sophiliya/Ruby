require_relative 'train'

class CargoTrain < Train
  protected

  def able_to_attach?(wagon)
    @current_speed.zero? && wagon.class == CargoWagon
  end
end
