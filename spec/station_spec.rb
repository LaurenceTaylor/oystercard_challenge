require 'station'

describe Station do
  let(:station) { Station.new('Liverpool Street', 1) }

  it 'should have a name attribute' do
    expect(station.name).to eq('Liverpool Street')
  end

  it 'should have a zone attribute' do
    expect(station.zone).to eq(1)
  end
end
