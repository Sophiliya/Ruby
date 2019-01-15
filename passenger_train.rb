class PassengerTrain < Train
  protected

  def able_to_attach?(wagon)
    @current_speed == 0 && wagon.class == PassengerWagon
  end
end
