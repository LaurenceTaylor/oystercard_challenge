require 'oystercard'

describe Oystercard do
  it 'has a default balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'tops up the card' do
      initial_balance = subject.balance
      expect(subject.top_up(10)).to eq(initial_balance + 10)
    end

    it "has a maximum capacity of 90" do
      message = "you have reached maximum top up capacity of #{Oystercard::MAXIMUM_CAPACITY}"
      subject.top_up(Oystercard::MAXIMUM_CAPACITY)
      expect { subject.top_up(1) }.to raise_error message
    end
  end
end
