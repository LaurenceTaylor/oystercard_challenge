require 'oystercard'

describe Oystercard do
  it 'has a default balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'tops up the card' do
    initial_balance = subject.balance
    expect(subject.top_up(10)).to eq(initial_balance + 10)
  end
end
