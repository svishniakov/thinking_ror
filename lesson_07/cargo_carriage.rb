class CargoCarriage < Carriage
  attr_reader :free_capacity, :capacity

  def initialize(capacity)
    @capacity = capacity.to_f
    @free_capacity = @capacity
    super()
  end

  def take_capacity(capacity)
    @free_capacity -= capacity unless (@free_capacity - capacity) <= 0
  end

  def taken_capacity
    @capacity - @free_capacity
  end
end
