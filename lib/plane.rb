class Plane

  attr_reader :airport, :flying

  def initialize
    @flying = true
  end

  def land(airport)
    fail "Cannot land: plane is already at airport" if landed
    @flying = false
    @airport = airport
  end

  def take_off
    fail "Cannot take off: plane is flying" if flying
    @airport = nil
    @flying = true
  end

  private

  def landed
    !flying
  end
end
