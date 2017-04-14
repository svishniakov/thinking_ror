class PassengerTrain < Train
  def correct_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
