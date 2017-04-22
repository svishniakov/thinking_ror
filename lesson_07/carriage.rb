require_relative 'manufacturer'

class Carriage
  include Manufacturer
  attr_accessor :number

  def initialize
    @number = Random.rand(10..100)
  end
end
