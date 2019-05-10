require 'journey'

describe Journey do
  let(:station_double) { double(:station, name: 'Liverpool Street', zone: 1) }
  let(:exit_station_double) { double(:station, name: 'Bank', zone: 1) }
  subject { Journey.new(station_double) }

  it 'should store entry station' do
    expect(subject.entry_station).to eq(station_double)
  end

  it 'should have entry_station be nil by default' do
    journey = Journey.new
    expect(journey.entry_station.nil?).to eq(true)
  end

  it 'should store entry station in a hash' do
    expect(subject.journey).to eq({ station_double => nil })
  end

  describe '#finish_journey' do
    before(:each) do
      subject.finish_journey(exit_station_double)
    end

    it 'should add exit station to journey hash' do
      expect(subject.journey).to eq({ station_double => exit_station_double })
    end

    it 'should change entry_station to nil' do
      expect(subject.entry_station.nil?).to eq(true)
    end
  end
end
