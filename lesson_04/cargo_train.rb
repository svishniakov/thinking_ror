class CargoTrain < Train
  def type
    2
  end

  def correct_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
