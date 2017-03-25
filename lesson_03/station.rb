# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  attr_accessor :trains, :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains  = []
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def all_trains(train_type = nil)
      if train_type?
        @trains.select{ |train| train.type == train_type }
      else
        @trains
      end
    end
end
