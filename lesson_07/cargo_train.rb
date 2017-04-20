class CargoTrain < Train

  protected

  def correct_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
