require 'plane'

describe 'Plane' do

  subject(:plane) {Plane.new}
  let(:airport) {Airport.new}

  it 'initialised plane is flying' do
    expect(plane.flying).to eq true
  end

  describe '#land' do
    it 'plane is not flying' do
      plane.land(airport)
      expect(plane.flying).to eq false
    end

    it 'plane is at selected airport' do
      plane.land(airport)
      expect(plane.airport).to eq airport
    end
  end

  describe '#take_off' do
    it 'plane should not be at airport' do
      plane.land(airport)
      plane.take_off
      expect(plane.airport).to eq nil
    end

    it 'plane is flying after take off' do
      plane.land(airport)
      plane.take_off
      expect(plane.flying).to eq true
    end
  end


end
