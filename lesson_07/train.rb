require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :carriages

  NUMBER_FORMAT = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i

  # Train types
  # 1 - passenger
  # 2 - cargo

  @@all_trains = {}

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @carriages = []
    @@all_trains[number] = self
  end

  def valid?
    validate!
  rescue => e
    puts e
    false
  end

  def self.all_trains
    @@all_trains.each do |key, value|
        type = value.is_a?(PassengerTrain) ? "Passenger" : "Cargo"
      puts "Number - #{key}, Type - #{type}, Carriages - #{value.carriages.size}"
    end
  end

  def self.find(number)
    @@all_trains[number]
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

  def detach_carriage(number)
    @carriages.delete_if { |carriage| carriage.number == number } if @speed == 0
  end

  def all_carriages
    @carriages.each do |carriage|
      if carriage.instance_of?(CargoCarriage)
        puts "Cargo carriage #: #{carriage.number}, total capacity: #{carriage.capacity}, free capacity: #{carriage.free_capacity}"
      else
        puts "Passenger carriage #: #{carriage.number}, total seats: #{carriage.seats}, free seats: #{carriage.free_seats}"
      end
    end
  end

  def each_carriage
    @carriages.each { |carriage| yield(carriage) }
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

  protected

  def validate!
    raise 'Invalid train number format' if @number !~ NUMBER_FORMAT
    true
  end
end
