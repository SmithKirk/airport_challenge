require 'airport'

describe 'Airport' do

  subject(:airport) {Airport.new}
  let(:plane) {Plane.new}

  it 'to initialise with capacity equal to DEFAULT_CAPACITY' do
      expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
  end

  it 'default capacity can be overridden' do
    airport.edit_capacity(10)
    expect(airport.capacity).to eq 10
  end

  describe '#take_off' do
    context 'when not stormy' do
      before do
        allow(airport).to receive(:stormy?).and_return false
      end

      it 'plane told to take off is not at airport' do
        airport.land(plane)
        airport.take_off(plane)
        expect(airport.planes).not_to include(plane)
      end
    end

    context 'when stormy' do
      before do
        allow(airport).to receive(:stormy?).and_return true
      end

      it 'take off raises error' do
        expect{airport.take_off(plane)}.to raise_error("Cannot take off: Stormy")
      end
    end
  end

  describe '#land' do
    context 'when not stormy' do
      before do
        allow(airport).to receive(:stormy?).and_return false
      end

      it 'airport responds to land' do
        expect(airport).to respond_to(:land).with(1).argument
      end

      it 'landed plane is at airport' do
        airport.land(plane)
        expect(airport.planes).to include(plane)
      end

      context 'when full' do
        before do
          20.times do
            airport.land(plane)
          end
        end
        it 'raises an error' do
          expect{airport.land(plane)}.to raise_error("Cannot land: airport full")
        end

      end
    end



    context 'when stormy' do
      before do
        allow(airport).to receive(:stormy?).and_return true
      end

      it 'landing raises error' do
        expect{airport.land(plane)}.to raise_error("Cannot land: Stormy")
      end
    end
  end


end
