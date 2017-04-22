class CargoCarriage < Carriage
  attr_reader :free_volume

  def initialize(volume)
    @volume = volume.to_f
    @free_volume = @volume
  end

  def take_volume(volume)
    @free_volume -= volume unless (@free_volume - volume) <= 0
  end

  def taken_volume
    @volume - @free_volume
  end
end
