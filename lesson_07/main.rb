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

    case gets.chomp.to_i
      when 1
        routes_stations_menu
      when 2
        trains_carriages_menu
      when 0
        exit
      else
        wrong_option_message
        main_menu
    end
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
      wrong_option_message
      main_menu
    end
  end

  def trains_carriages
    case gets.chomp.to_i
      when 1
        create_train
      when 2
        manage_trains
      when 3
        route_train_attach
      when 0
        main_menu
      else
        wrong_option_message
        trains_carriages
    end
  end

  def create_route
    attempts = 0
    begin
      puts "-" * 50 + "\nFirst station name\n"
      start_station = gets.chomp
      puts "End stations name"
      end_station = gets.chomp
      raise ArgumentError if start_station.empty? || end_station.empty?
    rescue ArgumentError
      attempts += 1
      if attempts <= 3
        name_blank_message
        retry
      else
        main_menu_message
        main_menu
      end
    end

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
    case train_type
      when 1
        PassengerTrain.new(train_number)
        puts "*" * 49 + "*\n" + "Passenger train number #{train_number} created\n" + "*" * 50
      when 2
        CargoTrain.new(train_number)
        puts "*" * 49 + "*\n" + "Cargo train number #{train_number} created\n" + "*" * 50
      else
        puts "*" * 50 + "\nIncorrect train type\n" + "*" * 50
        create_train
    end
    trains_carriages_menu
  end

  def manage_route(route)
    manage_route_options
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
      wrong_option_message
      main_menu
    end
  end

  def train_route_attach(route)
    puts Train.all_trains

    begin
      number = gets.chomp
      raise "Number couldn't be blank" if number.empty?
    rescue
      number_blank_message
      previous_menu_message
      manage_route(route)
    end

    train = Train.find(number)

    begin
      raise ArgumentError if train.nil?
    rescue ArgumentError
      train_not_found
      previous_menu_message
      manage_route(route)
    end

    train.train_route(route)
  end

  def route_train_attach
    puts Train.all_trains

    begin
      number = gets.chomp
      raise "Number can't be blank" if number.empty?
    rescue
      number_blank_message
      trains_carriages
    end

    train = Train.find(number)
    puts Route.all_routes

    begin
      route_index = Integer(gets.chomp)
    rescue
      wrong_input_message
      previous_menu_message
      trains_carriages
    end

    route = Route.find(route_index)
    train.train_route(route)
  end

  def manage_routes
    puts Route.all_routes
    attempts = 0

    begin
      route_index = Integer(gets.chomp)
    rescue
      attempts += 1
      if attempts <= 3
        wrong_input_message
        retry
      else
        previous_menu_message
        routes_stations
      end
    end

    route = Route.find(route_index)
    manage_route(route)
  end

  def manage_trains
    puts Train.all_trains
    number = gets.chomp
    train = Train.find(number)

    begin
      raise ArgumentError if train.nil?
    rescue ArgumentError
      train_not_found
      previous_menu_message
      trains_carriages
    end

    manage_train(train)
  end

  def manage_train(train)
    manage_train_options
    case gets.chomp.to_i
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
      manage_train(train)
    end
  end

  def create_carriage(train)
    if train.is_a?(PassengerTrain)
      puts "Please enter total available seats"
      seats = gets.chomp
      train.attach_carriage(PassengerCarriage.new(seats))
    else
      puts "Please enter total capacity"
      capacity = gets.chomp
      train.attach_carriage(CargoCarriage.new(capacity))
    end
    manage_train(train)
  end

  def delete_carriage(train)
    puts "*" * 50
      list_carriages(train)
    puts "Please enter carriage number to be detached"

    begin
      carriage_number = Integer(gets.chomp)
    rescue
      wrong_input_message
      previous_menu_message
    end

    train.detach_carriage(carriage_number)
    train.all_carriages
    manage_train(train)
  end

  def list_carriages(train)
    train.each_carriage{ |carriage| if carriage.instance_of?(CargoCarriage)
      puts "Cargo carriage #: #{carriage.number}, total capacity: #{carriage.capacity}, available capacity: #{carriage.free_capacity}"
    else
      puts "Passenger carriage #: #{carriage.number}, total seats: #{carriage.seats}, available seats: #{carriage.free_seats}"
    end}
  end

  def create_station(route)
    puts "-" * 50
    puts "Please enter station name"
    new_station = gets.chomp.to_s

    if new_station.empty?
      name_blank_message
      previous_menu_message
      manage_route(route)
    else
      route.add_station(new_station)
      puts "Station #{new_station} created"
    end

    route.show_route
    manage_route(route)
  end

  def delete_station(route)
    puts "-" * 50
    route.show_route
    puts "Please choose station to remove"

    begin
      station_index = Integer(gets.chomp)
    rescue
      wrong_input_message
      previous_menu_message
      manage_routes
    end

    route.del_station(station_index)
    puts "-" * 50
    route.show_route
    manage_route(route)
  end
end

main = Main.new
main.main_menu
