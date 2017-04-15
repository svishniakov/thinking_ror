module Mixins
  # Menus
  def main_menu_options
    puts "----------------- Main menu ----------------------"
    puts "1 - routes and stations"
    puts "2 - trains and carriages"
    puts "0 - exit"
    puts "\nPlease select an option:"
  end

  def routes_stations_menu_options
    puts "-" * 50 + "\nStations and routes menu. Now you can:\n"
    puts "1 - create new route"
    puts "2 - manage routes/attach to a train"
    puts "0 on Enter - go to main menu"
  end

  def trains_carriages_menu_options
    puts "-" * 50 + "\nTrains and carriages menu. Now you can:\n"
    puts "1 - create new train"
    puts "2 - manage train"
    puts "3 - attach train to the route"
    puts "0 on Enter - go to main menu"
  end

  def manage_route_options
    puts "-" * 50 + "\nNow you can manage newly created route\n"
    puts "1 - create station"
    puts "2 - delete station"
    puts "3 - manage routes"
    puts "4 - attach train to the route"
  end

  def manage_train_options
    puts "-" * 50 + "\nNow you can manage chosen train\n"
    puts "1 - create carriage"
    puts "2 - delete carriage"
    puts "3 - choose another train"
    puts "4 - back to trains and carriages menu"
  end

  # Find with messages
  def available_trains
    puts "--------- Available trains ----------\n\n"
    puts Train.all_trains
    puts "\n********** Please enter train number *********"
  end

  def available_routes
    puts "--------- Available routes ----------\n\n"
    puts Route.all_routes
    puts "\n****** Please choose route to change ********\n"
  end

  # Messages
  def train_not_found
    puts "**********************************************\n"
    puts "*             Train not found!!!             *\n"
    puts "**********************************************\n\n"
  end

  def number_blank_message
    puts "**********************************************\n"
    puts "*      Train number can't be blank!!!        *\n"
    puts "**********************************************\n\n"
  end

  def name_blank_message
    puts "**********************************************\n"
    puts "*           Name can't be blank!!!           *\n"
    puts "**********************************************\n\n"
  end

  def main_menu_message
    puts "**********************************************\n"
    puts "*         Returning to the main menu         *\n"
    puts "**********************************************\n\n"
  end

  def wrong_option_message
    puts "**********************************************\n"
    puts "*        You've selected wrong option        *\n"
    puts "**********************************************\n\n"
  end

  def previous_menu_message
    puts "**********************************************\n"
    puts "*       Returning to the previous menu       *\n"
    puts "**********************************************\n\n"
  end

  def wrong_input_message
    puts "**********************************************\n"
    puts "*                Wrong input                 *\n"
    puts "**********************************************\n\n"
  end
end
