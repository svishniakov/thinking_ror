class Train


  def initialize(no, type = 0)
    @no = no
    @speed = 0
    @carriages = []
  end

  def speedup(speed)
    @speed + speed
  end

  def stop
    @speed = 0
  end

  def attach_carriage(carriage)
    @carriages << carriage if @speed == 0 && correct_carriage?(carriage)
  end

  def detach_carriage
    @carriages.delete_at(-1) if @speed == 0
  end

  def train_route(route)
    @train_route = route
    @train_station_id = 0
  end

  def train_station
    @train_route.stations[@train_station_id]
  end

  def next_station
    @train_route.stations[@train_station_id + 1] unless @train_station_id == @train_route.stations.size - 1
  end

  def previous_station
    @train_route.stations[@train_station_id - 1] unless @train_station_id == 0
  end

  def station_forward
    if next_station?
      next_station.train_arrival(self)
      train_station.train_departure(self)
    else
      puts "End station"
    end
  end

  def station_backward
    if previous_station?
      previous_station.train_arrival(self)
      train_station.train_departure(self)
    else
      puts "You are at the beginning of the route"
    end
  end
end
