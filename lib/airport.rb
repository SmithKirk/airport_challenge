require_relative 'weather'
require_relative 'plane'

class Airport

  attr_reader :planes, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @weather = Weather.new
    @planes = []
  end

  def land(plane)
    fail "Cannot land: airport full" if full?
    fail "Cannot land: Stormy" if stormy?
    fail "Cannot land: plane is already at airport" if at_airport?(plane)
    @planes << plane
    plane.land(self)
  end

  def take_off(plane)
    fail "Cannot take off: plane not at airport" unless at_airport?(plane)
    fail "Cannot take off: Stormy" if stormy?
    @planes.delete(plane)
    plane.take_off
    plane
  end

  def edit_capacity(new_capacity)
    @capacity = new_capacity
  end

  private
  def stormy?
    @weather.stormy?
  end

  def full?
    @planes.size >= @capacity
  end

  def at_airport?(plane)
    @planes.include?(plane)
  end

  def flying?(plane)
    plane.flying == true
  end
end
