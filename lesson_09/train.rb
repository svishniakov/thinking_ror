require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Validation
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :carriages

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
    register_instance
  end

  def self.all_trains
    if @@all_trains.empty?
      puts 'There are no trains available. Please create train first.'
    else
      puts "\n********** Available trains ******************\n\n"
      @@all_trains.each do |key, value|
        type = value.is_a?(PassengerTrain) ? 'Passenger' : 'Cargo'
        puts "Number - #{key}, Type - #{type}, Carriages - #{value.carriages.size}"
      end
      puts "\n********** Please enter train number *********"
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
    @carriages << carriage if @speed.zero? && correct_carriage?(carriage)
  end

  def detach_carriage(number)
    @carriages.delete_if { |carriage| carriage.number == number } if @speed.zero?
  end

  def each_carriage
    @carriages.each { |carriage| yield(carriage) }
  end

  def train_attach_route(route)
    @train_route = route
    @station_id = 0
  end

  def train_station
    @train_route.stations[@station_id]
  end

  def next_station
    @train_route.stations[@station_id + 1] unless @station_id == @train_route.stations.size - 1
  end

  def previous_station
    @train_route.stations[@station_id - 1] unless @station_id.zero?
  end

  def station_forward
    if next_station?
      next_station.train_arrival(self)
      train_station.train_departure(self)
    else
      puts 'End station'
    end
  end

  def station_backward
    if previous_station?
      previous_station.train_arrival(self)
      train_station.train_departure(self)
    else
      puts 'You are at the beginning of the route'
    end
  end
end
