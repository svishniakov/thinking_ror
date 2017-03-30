class Station
  attr_accessor :trains, :name

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains  = []
    @@all_stations << self
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

  def self.all_stations
    @@all_stations
  end
end
