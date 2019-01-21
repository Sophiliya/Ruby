require_relative 'train'

class CargoTrain < Train
  protected

  def able_to_attach?(wagon)
    @current_speed == 0 && wagon.class == CargoWagon
  end
end
