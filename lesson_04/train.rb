class Train
  attr_reader :no, :type, :carriages
  # Train types
  # 1 - passenger
  # 2 - cargo
  # 0 - undefinite (default)

  @@all_trains = []

  def initialize(no, type = 0)
    @no = no
    @type = type
    @speed = 0
    @carriages = []
    @@all_trains << self
  end

  def self.all_trains
    @@all_trains.each_with_index do |train, index|
      train.type == 1 ? type = "Passenger" : type = "Cargo"
      puts "#{index}: No - #{train.no}, Type - #{type}, Carriages - #{train.carriages.count}"
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
    @carriages << carriage if @speed == 0
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
