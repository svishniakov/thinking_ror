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
    unless @@all_routes.empty?
      puts "******** Available routes *********************\n"
      @@all_routes.each_with_index do |route, index|
        puts "#{index} - #{route.stations}"
      end
      puts "\n****** Please select route  *****************\n"
    else
      puts "There are no routes available. Please create route first."
    end
  end

  def show_route
    @stations.each.with_index { |station, index| puts "#{index} - #{station}" }
  end

  private

  def validate!
    if @stations.size < 2
      raise "Incomplete route"
    elsif @stations.first.class.is_a?(Station) && @stations.last.class.is_a?(Station)
      raise "Invalid object"
    end
  end
end
