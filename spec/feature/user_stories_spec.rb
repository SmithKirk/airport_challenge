describe 'Features' do

  let(:airport){Airport.new}
  let(:plane){Plane.new}
  let(:weather){Weather}

  context 'Not stormy' do
    before do
      allow_any_instance_of(weather).to receive(:stormy?).and_return false
    end

    # As an air traffic controller
    # So I can get passengers to a destination
    # I want to instruct a plane to land at an airport and confirm that it has landed
    it 'instruct plane to land and confirm it is at airport' do
      airport.land(plane)
      expect(airport.planes).to include(plane)
      expect(plane.airport).to eq airport
    end

    # As an air traffic controller
    # So I can get passengers on the way to their destination
    # I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport
    it 'instruct plane to take off and confirm it has left airport' do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.planes).not_to include(plane)
      expect(plane.airport).to eq nil
    end

    # Landed plane must be at an airport
    it 'non-flying planes must be in an airport' do
      airport.land(plane)
      expect(plane.airport).to eq airport
    end

    # Plane can only take off from airport it landed at
    it 'take off from other airport raises error' do
      other_airport = Airport.new
      airport.land(plane)
      expect{other_airport.take_off(plane)}.to raise_error ("Cannot take off: plane not at airport")
    end

    # Flying planes cannot take off or be at airport
    it 'take off raises error if plane not at airport' do
      expect{plane.take_off}.to raise_error ("Cannot take off: plane is flying")
      expect{airport.take_off(plane)}.to raise_error ("Cannot take off: plane not at airport")
    end

    # A landed plane cannot land again and must be at airport
    it 'land raises error if already landed' do
      airport.land(plane)
      expect{airport.land(plane)}.to raise_error ("Cannot land: plane is already at airport")
    end

    context 'when full' do
      before do
        Airport::DEFAULT_CAPACITY.times do
          airport.land(Plane.new)
        end
      end

      # As an air traffic controller
      # To ensure safety
      # I want to prevent landing when the airport is full
      it 'land raises an error' do
        expect{airport.land(plane)}.to raise_error("Cannot land: airport full")
      end
    end
  end

  context 'Stormy' do
    before do
      allow_any_instance_of(weather).to receive(:stormy?).and_return false
      airport.land(plane)
      allow_any_instance_of(weather).to receive(:stormy?).and_return true
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent takeoff when weather is stormy
    it 'take off raises error' do
      expect{airport.take_off(plane)}.to raise_error("Cannot take off: Stormy")
    end

    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when weather is stormy
    it 'landing raises error' do
      expect{airport.land(plane)}.to raise_error("Cannot land: Stormy")
    end
  end

  # As the system designer
  # So that the software can be used for many different airports
  # I would like a default airport capacity that can be overridden as appropriate
  it 'airport has a default capacity that can be overridden' do
    expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
    airport.edit_capacity(10)
    expect(airport.capacity).to eq 10
  end
end
