class Plane

  attr_reader :flying, :airport

  def initialize
    @flying = true
  end

  def land(airport)
    @flying = false
    @airport = airport
  end

  def take_off
    @airport = nil
    @flying = true
  end
end
