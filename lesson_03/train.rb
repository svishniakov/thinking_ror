# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_reader :speed, :cars, :type, :no

  def initialize(no, type, cars)
    @no = no
    @type = type
    @cars = cars
    @speed = 0
    @train_station
  end

  def speedup(speed)
    @speed + speed
  end

  def stop
    @speed = 0
  end

  def attach_car
    if @speed == 0
      @cars += 1
    else
      puts "Impossible attach a car"
    end
  end

  def detach_car
    if @speed == 0 && @cars > 0
      @cars -= 1
    else
      puts "Impossible detach a car"
    end
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
