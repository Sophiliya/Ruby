class PassengerTrain < Train
  protected

  def attachable?(wagon)
    @current_speed == 0 && wagon.class == PassengerWagon
  end
end
