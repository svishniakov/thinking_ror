class Station
  include Mixins
  attr_accessor :trains, :name

  STATION_NAME_FORMAT = /^[a-zа-я ]{3,}$/i

  @@all_stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self
  end

  def valid?
    validate!
  rescue => e
    puts e.message.to_s
    false
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def all_trains(train_type = nil)
    if train_type?
      @trains.select { |train| train.type == train_type }
    else
      @trains
    end
  end

  def self.all
    @@all_stations
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  private

  def validate!
    raise 'Wrong station name' if name !~ STATION_NAME_FORMAT
    true
  end
end
