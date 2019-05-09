class Oystercard
  attr_reader :balance

  MAXIMUM_CAPACITY = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(money)
    fail "you have reached maximum top up capacity of £#{MAXIMUM_CAPACITY}" if full?
    @balance += money
  end

  def touch_in
    fail "you don't have enough funds for a journey" if enough_money?
    @travelling = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @travelling = false
  end

  def in_journey?
    @travelling
  end

  private
  def full?
    @balance >= MAXIMUM_CAPACITY
  end

  def enough_money?
    @balance < MINIMUM_FARE
  end

  def deduct(money)
    @balance -= money
  end
end
