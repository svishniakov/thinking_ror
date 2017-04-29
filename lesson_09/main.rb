require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'mixins'

class Main
  include Mixins

  def main_menu
    main_menu_options
    option = gets.chomp.to_i
    send(MAIN_MENU[option] || wrong_option_message)
  end

  private

  def routes_stations_menu
    routes_stations_menu_options
    routes_stations
  end

  def trains_carriages_menu
    trains_carriages_menu_options
    trains_carriages
  end

  def routes_stations
    option = gets.chomp.to_i
    send(ROUTES_STATIONS[option] || wrong_option_message)
  end

  def trains_carriages
    option = gets.chomp.to_i
    send(TRAINS_CARRIAGES[option] || wrong_option_message)
  end

  def create_route
    start_station = create_route_station("\nPlease enter first station name:\n")
    end_station = create_route_station("\nPlease enter last station name:\n")

    route = Route.new(start_station, end_station)
    puts "\nRoute #{route.show_route} created"
    manage_route(route)
  end

  def create_route_station(message)
    puts message
    Station.new(gets.chomp)
  end

  def create_train
    puts '-' * 50 + "\nPlease enter train number\n"
    train_number = gets.chomp
    puts 'Please choose train type:' + "\n1 - passenger\n" + "2 - cargo\n"
    train_type = gets.chomp.to_i
    create_train_with_type(train_number, train_type)
  end

  def create_train_with_type(train_number, train_type)
    case train_type
    when 1
      create_passenger_train(train_number)
    when 2
      create_cargo_train(train_number)
    else
      puts '*' * 50 + "\nIncorrect train type\n" + '*' * 50
      create_train
    end
    trains_carriages_menu
  end

  def create_passenger_train(train_number)
    PassengerTrain.new(train_number)
    puts '*' * 49 + "*\n" + "Passenger train number #{train_number} created\n" + '*' * 50
  end

  def create_cargo_train(train_number)
    CargoTrain.new(train_number)
    puts '*' * 49 + "*\n" + "Cargo train number #{train_number} created\n" + '*' * 50
  end

  def manage_route(route)
    manage_route_options
    manage_route_choice(route, gets.chomp.to_i)
  end

  def manage_route_choice(route, choice)
    case choice
    when 1
      create_station(route)
    when 2
      delete_station(route)
    when 3
      manage_routes
    when 4
      train_route_attach(route)
    when 5
      route_details(route)
    else
      wrong_option_message
    end
  end

  def train_route_attach(route)
    puts Train.all_trains
    train = Train.find(select_route)
    train_find(train)
    route_station = route.stations.first
    route_station.train_arrival(train)
    manage_route(route)
  end

  def select_route
    number = gets.chomp
    raise "Number couldn't be blank" if number.empty?
  rescue
    main_menu
  end

  def train_find(train)
    raise 'Train not found' if train.nil?
  rescue
    trains_carriages
  end

  def route_details(route)
    route.stations.each do |station|
      puts "Station name: #{station.name}"
      station.each_train do |train|
        type = train.is_a?(CargoTrain) ? 'Cargo' : 'Passenger'
        puts ' Trains on the station'
        puts "  Train number: #{train.number}, Train type: #{type}" \
             ", Attached carriages: #{train.carriages.size}"
      end
    end
    manage_route(route)
  end

  def route_train_attach
    puts Train.all_trains
    train = Train.find(gets.chomp.to_i)
    route_station = Route.find(find_route_index).stations.first
    route_station.train_arrival(train)
  end

  def select_train
    number = gets.chomp
    raise "Number can't be blank" if number.empty?
  rescue
    trains_carriages
  end

  def find_route_index
    puts Route.all_routes
    begin
      Integer(gets.chomp)
    rescue
      trains_carriages
    end
  end

  def manage_routes
    puts Route.all_routes

    begin
      route_index = Integer(gets.chomp)
    rescue
      wrong_input_message
      routes_stations
    end

    route = Route.find(route_index)
    manage_route(route)
  end

  def manage_trains
    puts Train.all_trains
    number = gets.chomp
    train = Train.find(number)

    begin
      raise 'Train not found' if train.nil?
    rescue
      trains_carriages
    end

    manage_train(train)
  end

  def manage_train(train)
    manage_train_options
    manage_train_choice(train, gets.chomp.to_i)
  end

  def manage_train_choice(train, choice)
    case choice
    when 1
      create_carriage(train)
    when 2
      delete_carriage(train)
    when 3
      list_carriages(train)
      manage_train(train)
    when 4
      manage_trains
    when 5
      trains_carriages_menu
    else
      wrong_option_message
    end
  end

  def create_carriage(train)
    if train.is_a?(PassengerTrain)
      puts 'Please enter total available seats'
      seats = gets.chomp
      train.attach_carriage(PassengerCarriage.new(seats))
    else
      puts 'Please enter total capacity'
      capacity = gets.chomp
      train.attach_carriage(CargoCarriage.new(capacity))
    end
    manage_train(train)
  end

  def delete_carriage(train)
    list_carriages(train)
    puts 'Please enter carriage number to be detached'

    begin
      carriage_number = Integer(gets.chomp)
    rescue
      wrong_input_message
    end

    train.detach_carriage(carriage_number)
    train.all_carriages
    manage_train(train)
  end

  def list_carriages(train)
    puts '*' * 50
    train.each_carriage do |carriage|
      if carriage.instance_of?(CargoCarriage)
        puts "Cargo carriage #: #{carriage.number}, total capacity: #{carriage.capacity}" \
             ", available capacity: #{carriage.free_capacity}"
      else
        puts "Passenger carriage #: #{carriage.number}, total seats: #{carriage.seats}" \
             ", available seats: #{carriage.free_seats}"
      end
    end
  end

  def create_station(route)
    puts "-" * 50 + "-\n" + "Please enter station name"
    new_station = gets.chomp.to_s

    route.add_station(Station.new(new_station))
    puts "Station #{new_station} created"

    route.show_route
    manage_route(route)
  end

  def delete_station(route)
    route.show_route

    begin
      station_index = Integer(gets.chomp)
    rescue
      wrong_input_message
      manage_routes
    end

    route.del_station(station_index)
    route.show_route
    manage_route(route)
  end
end

main = Main.new
main.main_menu
