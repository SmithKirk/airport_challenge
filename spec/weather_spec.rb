require 'weather'

describe 'Weather' do

  subject(:weather) {Weather.new}

  it 'weather can be stormy' do
    allow(Kernel).to receive(:rand).and_return(8)
    expect(weather.stormy?).to eq true
  end

  it 'weather can be not stormy' do
    allow(Kernel).to receive(:rand).and_return(1)
    expect(weather.stormy?).to eq false
  end

end
