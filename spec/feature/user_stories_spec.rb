describe 'Features' do

  let(:airport){Airport.new}
  let(:plane){Plane.new}

  context 'Not stormy' do
    before do
      allow(airport).to receive(:stormy?).and_return false
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

    context 'when full' do
      before do
        20.times do
          airport.land(plane)
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
      allow(airport).to receive(:stormy?).and_return true
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
