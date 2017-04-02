class Train
  attr_reader :number, :carriages
  # Train types
  # 1 - passenger
  # 2 - cargo

  @@all_trains = []

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    @@all_trains << self
  end

  def self.all_trains
    @@all_trains.each_with_index do |train, index|
      train.is_a?(PassengerTrain) ? type = "Passenger" : type = "Cargo"
      # Alternative for is_a?
      # type = case train
      #          when PassengerTrain
      #            'Passenger'
      #          when CargoTrain
      #            'Cargo'
      #        end
      puts "#{index}: No - #{train.number}, Type - #{type}, Carriages - #{train.carriages.count}"
    end
  end

  def self.find(index)
    @@all_trains[index]
  end

  def speedup(speed)
    @speed + speed
  end

  def stop
    @speed = 0
  end

  def attach_carriage(carriage)
    @carriages << carriage if @speed == 0 && correct_carriage?(carriage)
  end

  def detach_carriage(carriage)
    @carriages.delete_at(carriage) if @speed == 0
  end

  def all_carriages
    @carriages.each_with_index { |carriage, index| puts "#{index} - #{carriage}"}
  end

  def train_route(route)
    @train_route = route
    @train_station_id = 0
  end

  def train_station
    @train_route.stations[@train_station_id]
  end

  def next_station
    @train_route.stations[@train_station_id + 1] unless @train_station_id == @train_route.stations.size - 1
  end

  def previous_station
    @train_route.stations[@train_station_id - 1] unless @train_station_id == 0
  end

  def station_forward
    if next_station?
      next_station.train_arrival(self)
      train_station.train_departure(self)
    else
      puts "End station"
    end
  end

  def station_backward
    if previous_station?
      previous_station.train_arrival(self)
      train_station.train_departure(self)
    else
      puts "You are at the beginning of the route"
    end
  end
end
