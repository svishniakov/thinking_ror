require_relative 'mixins'

class Route
  include Mixins
  attr_reader :stations

  @@all_routes = []

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    @@all_routes << self
  end

  def valid?
    validate!
  rescue => e
    puts e
    false
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    @stations.delete_at(station)
  end

  def self.find(index)
    @@all_routes[index]
  end

  def self.all_routes
    @@all_routes.each_with_index do |route, index|
      puts "#{index} - #{route.stations}"
    end
  end

  def show_route
    @stations.each.with_index { |station, index| puts "#{index} - #{station}" }
  end

  private

  def validate!
    raise "Incomplete route" if @stations.size < 2
  end
end
