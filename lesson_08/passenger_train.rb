class PassengerTrain < Train
  protected

  def correct_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
