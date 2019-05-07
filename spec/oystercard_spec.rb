require 'oystercard'

describe Oystercard do
  max_capacity = Oystercard::MAXIMUM_CAPACITY
  min_fare = Oystercard::MINIMUM_FARE

  it 'has a default balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'tops up the card' do
      expect { subject.top_up(10) }.to change { subject.balance }.by +10
    end

    it "has a maximum capacity of 90" do
      message = "you have reached maximum top up capacity of #{max_capacity}"
      subject.top_up(max_capacity)
      expect { subject.top_up(1) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'changes in_journey to true' do
      subject.top_up(min_fare)
      expect(subject.touch_in).to eq(true)
    end
    it 'raises an error if the balance is less than 1' do
      message = "you don't have enough funds for a single journey"
      subject.top_up(0.5)
      expect { subject.touch_in }.to raise_error message
    end
  end

  describe '#touch_out' do
    it 'changes in_journey to false' do
      subject.top_up(min_fare)
      subject.touch_in
      expect(subject.touch_out).to eq(false)
    end
    it 'should reduce the balance by the minimum fare' do
      subject.top_up(min_fare)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by -(min_fare)
    end
  end
end
