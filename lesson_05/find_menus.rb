module FindMenus
  def available_trains
    puts "--------- Available trains ----------\n\n"
    puts Train.all_trains
    puts "\n********** Please enter train number *********"
  end

  def train_not_found
    puts "**********************************************\n"
    puts "*             Train not found!!!             *\n"
    puts "**********************************************\n\n"
  end

  def available_routes
    puts "--------- Available routes ----------\n\n"
    puts Route.all_routes
    puts "\n****** Please choose route to change ********\n"
  end
end