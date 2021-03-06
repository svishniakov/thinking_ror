require_relative 'validation'

class PassengerTrain < Train
  include Validation

  validate :number, presence: true, format: /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i

  protected

  def correct_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
