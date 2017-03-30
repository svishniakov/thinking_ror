require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'cargo_carriage'
require_relative 'passenger_train'
require_relative 'passenger_carriage'

class Main

  def main_menu
    puts "----------------- Main menu ----------------------"
    puts "1 - routes and stations"
    puts "2 - trains and carriages"
    puts "Anything else will stop the programm"
    puts "\nPlease select an option:"

    case gets.chomp.to_i
    when 1
      routes_stations_menu
    when 2
      trains_carriages_menu
    else
      exit
    end
  end

  private

  def routes_stations_menu
    puts "-" * 50
    puts "You've chosen stations and routes menu. Now you can:"
    puts "1 - create new route"
    puts "2 - manage routes"
    puts "0 on Enter - go to main menu"
    puts "Anything else will stop the programm"
    routes_stations
  end

  def routes_stations
    case gets.chomp.to_i
    when 1
      create_route
    when 2
      manage_routes
    when 0
      main_menu
    else
      exit!
    end
  end

  def create_route
    puts "-" * 50
    puts "First station name"
    start_station = gets.chomp
    puts "End stations name"
    end_station = gets.chomp
    route = Route.new(start_station, end_station)
    puts route
    manage_route(route)
  end

  def manage_route(route)
    puts "-" * 50
    puts "Now you can manage newly created route"
    puts "1 - create station"
    puts "2 - delete station"
    puts "3 - manage routes"
    puts "Anything else will stop the programm"
    case gets.chomp.to_i
    when 1
      create_station(route)
    when 2
      delete_station(route)
    when 3
      manage_routes
    else
      exit!
    end
  end

  def manage_routes
    puts "--------- Available routes ----------"
    puts Route.all_routes
    puts "Please choose route to change"
    route_index = gets.chomp.to_i
    route = Route.find(route_index)
    manage_route(route)
  end

  def create_station(route)
    puts "-" * 50
    puts "Please enter station name"
    new_station = gets.chomp
    route.add_station(new_station)
    puts "Station #{new_station} created"
    route.show_route
    manage_route(route)
  end

  def delete_station(route)
    puts "-" * 50
    route.show_route
    puts "Please choose station to remove"
    station_index = gets.chomp.to_i
    route.del_station(station_index)
    puts "-" * 50
    route.show_route
    manage_route(route)
  end
end

main = Main.new
main.main_menu
