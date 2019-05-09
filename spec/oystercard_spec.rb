require 'oystercard'

describe Oystercard do
  max_capacity = Oystercard::MAXIMUM_CAPACITY
  min_fare = Oystercard::MINIMUM_FARE

  let(:station) { double('station') }
  let(:exit_station) { double('exit station') }

  def top_up_touch_in
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in(station)
  end

  describe '#top_up' do
    it 'should increase the balance on the card' do
      expect { subject.top_up(min_fare) }.to change { subject.balance }.by(min_fare)
    end

    it "should have a maximum capacity of #{max_capacity}" do
      message = "top up capacity hit: £#{max_capacity}"
      subject.top_up(max_capacity)
      expect { subject.top_up(min_fare) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'should cause in_journey to be true' do
      top_up_touch_in
      expect(subject.in_journey?).to eq(true)
    end

    it "should raise an error if the balance is less than #{min_fare}" do
      message = "you don't have enough funds for a journey"
      subject.top_up(min_fare / 2)
      expect { subject.touch_in(station) }.to raise_error message
    end
  end

  describe '#touch_out' do
    before(:each) do
      top_up_touch_in
    end

    it 'should cause in_journey? to be false' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq(false)
    end

    it 'should reduce the balance by the minimum fare' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -(min_fare)
    end
  end

  describe '#journey_history' do
    it 'should have no journeys by default' do
      expect(subject.journey_history).to eq([])
    end

    it 'should store journeys (hashes of entry_station and exit_station)' do
      top_up_touch_in
      subject.touch_out(exit_station)
      expect(subject.journey_history).to eq([station => exit_station])
    end
  end
end
