require_relative 'validation'

class Station
  include Mixins
  include Validation
  attr_accessor :trains, :name

  validate :name, presence: true, format: /^[a-zа-я ]{3,}$/i

  @@all_stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
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
end
