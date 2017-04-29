module Mixins
  # Menus
  def main_menu_options
    puts '----------------- Main menu ----------------------'
    puts '1 - routes and stations'
    puts '2 - trains and carriages'
    puts '0 - exit'
    puts "\nPlease select an option:"
  end

  MAIN_MENU = {
    1 => 'routes_stations_menu',
    2 => 'trains_carriages_menu',
    0 => 'exit'
  }.freeze

  def routes_stations_menu_options
    puts '-' * 50 + "\nStations and routes menu. Now you can:\n"
    puts '1 - create new route'
    puts '2 - manage routes'
    puts '0 on Enter - go to main menu'
  end

  ROUTES_STATIONS = {
    1 => 'create_route',
    2 => 'manage_routes',
    0 => 'main_menu'
  }.freeze

  def trains_carriages_menu_options
    puts '-' * 50 + "\nTrains and carriages menu. Now you can:\n"
    puts '1 - create new train'
    puts '2 - manage train'
    puts '3 - attach train to the route'
    puts '0 on Enter - go to main menu'
  end

  TRAINS_CARRIAGES = {
    1 => 'create_train',
    2 => 'manage_trains',
    3 => 'route_train_attach',
    0 => 'main_menu'
  }.freeze

  def manage_route_options
    puts '-' * 50 + "\nNow you can manage selected route\n"
    puts '1 - create station'
    puts '2 - delete station'
    puts '3 - select another route'
    puts '4 - attach train to the route'
    puts '5 - route details'
  end

  def manage_train_options
    puts '-' * 50 + "\nNow you can manage selected train\n"
    puts '1 - attach carriage'
    puts '2 - detach carriage'
    puts '3 - list all carriages'
    puts '4 - choose another train'
    puts '5 - back to trains and carriages menu'
  end

  # Messages
  def name_blank_message
    puts "**********************************************\n"
    puts "*           Name can't be blank!!!           *\n"
    puts "**********************************************\n\n"
  end

  def main_menu_message
    puts "**********************************************\n"
    puts "*         Returning to the main menu         *\n"
    puts "**********************************************\n\n"
    main_menu
  end

  def wrong_option_message
    puts "**********************************************\n"
    puts "*        You've selected wrong option        *\n"
    puts "**********************************************\n\n"
    main_menu
  end

  def wrong_input_message
    puts "**********************************************\n"
    puts "*                Wrong input                 *\n"
    puts "**********************************************\n\n"
  end
end
