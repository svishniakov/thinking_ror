require_relative 'mixins'

class Route
  include Mixins
  attr_reader :stations

  @@all_routes = []

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    puts "#{start_station} - #{end_station}"
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

  def show_route
    puts '-' * 50
    @stations.each.with_index { |s, i| puts "#{i} - #{s.name}" }
    puts 'Please select station'
  end

  class << self
    def find(index)
      @@all_routes[index]
    end

    def all_routes
      if @@all_routes.empty?
        puts 'There are no routes available. Please create route first.'
      else
        puts "******** Available routes *********************\n"
        @@all_routes.each_with_index do |r, i|
          puts "#{i} - #{r.stations.map(&:name)}"
        end
        puts "\n****** Please select route  *****************\n"
      end
    end
  end

  private

  def validate!
    raise 'Invalid object' unless @stations[0].instance_of?(Station) || @stations[-1].instance_of?(Station)
    raise 'Incomplete routes' if @stations.size < 2
    true
  end
end
