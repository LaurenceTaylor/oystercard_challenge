require 'oystercard'

describe Oystercard do
  max_capacity = Oystercard::MAXIMUM_CAPACITY
  min_fare = Oystercard::MINIMUM_FARE

  let(:station) { double('station') }

  describe '#top_up' do
    it 'should increase the balance on the card' do
      expect { subject.top_up(min_fare) }.to change { subject.balance }.by(min_fare)
    end

    it "should have a maximum capacity of #{max_capacity}" do
      message = "you have reached top up capacity of £#{max_capacity}"
      subject.top_up(max_capacity)
      expect { subject.top_up(1) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'should cause in_journey to be true' do
      subject.top_up(min_fare)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it "should raise an error if the balance is less than #{min_fare}" do
      message = "you don't have enough funds for a journey"
      subject.top_up(min_fare / 2)
      expect { subject.touch_in(station) }.to raise_error message
    end

    it 'should store the entry station somewhere' do
      subject.top_up(min_fare)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    before(:each) do
      subject.top_up(min_fare)
      subject.touch_in(station)
    end

    it 'should cause in_journey? to be false' do
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

    it 'should reduce the balance by the minimum fare' do
      expect { subject.touch_out }.to change { subject.balance }.by -(min_fare)
    end
  end
end
