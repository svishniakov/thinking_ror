class PassengerCarriage < Carriage
  attr_reader :free_seats, :seats

  def initialize(seats)
    @seats = seats.to_i
    @free_seats = @seats
    super()
  end

  def take_seat
    @free_seats -= 1 unless @free_seats.zero?
  end

  def occupied_seats
    @seats - @free_seats
  end

end
