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
  attr_reader :train_speed, :train_cars, :train_type, :train_no

  def initialize(train_no, train_type, train_cars)
    @train_no = train_no
    @train_type = train_type
    @train_cars = train_cars
    @train_speed = 0
    @train_station
  end

  def speedup(speed)
    @train_speed + speed
  end

  def stop
    @train_speed = 0
  end

  def attach_car
    if @train_speed == 0
      @train_cars += 1
    else
      puts "Impossible attach a car"
    end
  end

  def detach_car
    if @train_speed == 0 && @train_cars > 0
      selftrain_cars -= 1
    else
      puts "Impossible detach a car"
    end
  end

  def train_route(route)
    @train_route = route
    @train_station = 0
  end

  def train_station
    @train_route.stations[@train_station]
  end

  def next_station
    @train_route.stations[@train_station + 1]
  end

  def previous_station
    @train_route.stations[@train_station - 1]
  end

  def train_next_station
    if @train_station == @train_route.stations.size - 1
      puts "End station"
    else
      train_station.train_arrival(self)
      previous_station.train_departure(self)
    end
  end

  def train_previous_station
    if @train_station == 0
      puts "You are at the beginning of the route"
    else
      previous_station.train_arrival(self)
      train_station.train_departure(self)
  end
end
