class PassengerTrain < Train
    def type
      1
    end

    def correct_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
