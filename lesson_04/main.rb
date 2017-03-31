require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'

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
    puts "-" * 50 + "\nStations and routes menu. Now you can:\n"
    puts "1 - create new route"
    puts "2 - manage routes/attach to a train"
    puts "0 on Enter - go to main menu"
    puts "Anything else will stop the programm"
    routes_stations
  end

  def trains_carriages_menu
    puts "-" * 50 + "\nTrains and carriages menu. Now you can:\n"
    puts "1 - create new train"
    puts "2 - manage train"
    puts "3 - attach train to the route"
    puts "0 on Enter - go to main menu"
    puts "Anything else will stop the programm"
    trains_carriages
  end

  def routes_stations
    case gets.chomp.to_i
    when 1
      create_route
    when 2
      manage_routes
    when 3
      route_train_attach
    when 0
      main_menu
    else
      exit!
    end
  end

  def trains_carriages
    case gets.chomp.to_i
    when 1
      create_train
    when 2
      manage_trains
    when 0
      main_menu
    else
      exit!
    end
  end

  def create_route
    puts "-" * 50 + "\nFirst station name\n"
    start_station = gets.chomp
    puts "End stations name"
    end_station = gets.chomp
    route = Route.new(start_station, end_station)
    puts "\nRoute #{route.show_route} created"
    manage_route(route)
  end

  def create_train
    puts "-" * 50 + "\nPlease enter train number\n"
    train_number = gets.chomp
    puts "Please choose train type:" + "\n1 - passenger\n" + "2 - cargo\n"
    train_type = gets.chomp.to_i
    create_train_type(train_number, train_type)
  end

  def create_train_type(train_number, train_type)
    if train_type == 1 || train_type == 2
      Train.new(train_number, train_type)
      train_type == 1 ? type = "Passenger" : type = "Cargo"
      puts "*" * 49 + "*\n" + "#{type} train number #{train_number} created\n" + "*" * 50
      trains_carriages_menu
    else
      puts "*" * 50 + "\nIncorrect train type\n" + "*" * 50
      create_train
    end
  end

  def manage_route(route)
    puts "-" * 50 + "\nNow you can manage newly created route\n"
    puts "1 - create station"
    puts "2 - delete station"
    puts "3 - manage routes"
    puts "4 - attach train to the route"
    puts "Anything else will stop the programm"
    case gets.chomp.to_i
    when 1
      create_station(route)
    when 2
      delete_station(route)
    when 3
      manage_routes
    when 4
      train_route_attach(route)
    else
      exit!
    end
  end

  def train_route_attach(route)
    puts "--------- Available trains ----------\n\n"
    puts Train.all_trains
    puts "Please choose trains to manage"
    train_index = gets.chomp.to_i
    train = Train.find(train_index)
    train.train_route(route)
  end

  def route_train_attach
    puts "--------- Available trains ----------\n\n"
    puts Train.all_trains
    puts "Please choose trains to manage"
    train_index = gets.chomp.to_i
    train = Train.find(train_index)

  end

  def manage_routes
    puts "--------- Available routes ----------\n\n"
    puts Route.all_routes
    puts "Please choose route to change"
    route_index = gets.chomp.to_i
    route = Route.find(route_index)
    manage_route(route)
  end

  def manage_trains
    puts "--------- Available trains ----------\n\n"
    puts Train.all_trains
    puts "Please choose trains to manage"
    train_index = gets.chomp.to_i
    train = Train.find(train_index)
    manage_train(train)
  end

  def manage_train(train)
    puts "-" * 50 + "\nNow you can manage chosen train\n"
    puts "1 - create carriage"
    puts "2 - delete carriage"
    puts "3 - choose another train"
    puts "4 - back to trains and carriages menu"
    puts "Anything else will stop the programm"
    case gets.chomp.to_i
    when 1
      create_carriage(train)
    when 2
      delete_carriage(train)
    when 3
      manage_trains
    when 4
      trains_carriages_menu
    else
      exit!
    end
  end

  def create_carriage(train)
    carriage = Carriage.new(train.type)
    train.attach_carriage(carriage)
    manage_train(train)
  end

  def delete_carriage(train)
    puts "*" * 50
    train.all_carriages
    puts "Please choose carriage to delete"
    carriage_index = gets.chomp.to_i
    train.detach_carriage(carriage_index)
    train.all_carriages
    manage_train(train)
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
