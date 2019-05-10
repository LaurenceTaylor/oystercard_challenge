require 'journey'

describe Journey do
  let(:station_double) { double(:station, name: 'Liverpool Street', zone: 1) }
  subject { Journey.new(station_double) }

  it 'should store entry station' do
    expect(subject.entry_station).to eq(station_double)
  end

  it 'should store entry station in a hash' do
    expect(subject.journey).to eq({ station_double => nil })
  end
end
