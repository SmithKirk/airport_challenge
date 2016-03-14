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

    it 'raise error if already landed' do
      plane.land(airport)
      expect{plane.land(airport)}.to raise_error ("Cannot land: plane is already at airport")
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

    it 'raises error if plane is already flying' do
      expect{plane.take_off}.to raise_error ("Cannot take off: plane is flying")
    end
  end


end
