class Oystercard
  attr_reader :balance

  MAXIMUM_CAPACITY = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "you have reached maximum top up capacity of #{MAXIMUM_CAPACITY}" if full?
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  private
  def full?
    @balance >= MAXIMUM_CAPACITY
  end
end
