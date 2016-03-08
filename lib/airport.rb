require_relative 'weather'
require_relative 'plane'

class Airport

  attr_reader :planes, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @planes = []
    @weather = Weather.new
    @capacity = capacity
  end

  def land(plane)
    fail "Cannot land: airport full" if full?
    fail "Cannot land: Stormy" if stormy?
    @planes << plane
    plane.land(self)
  end

  def take_off(plane)
    fail "Cannot take off: Stormy" if stormy? true
    @planes.delete(plane)
    plane.take_off
  end

  def edit_capacity(new_capacity)
    @capacity = new_capacity
  end

  private
  def stormy?
    weather.stormy?
  end

  def full?
    @planes.size >= @capacity
  end
end
