class Plane

  attr_reader :flying, :airport

  def initialize
    @flying = true
  end

  def land(airport)
    fail "Cannot land: plane is already at airport" unless @flying == true
    @flying = false
    @airport = airport
  end

  def take_off
    fail "Cannot take off: plane is flying" if @flying == true
    @airport = nil
    @flying = true
  end
end
