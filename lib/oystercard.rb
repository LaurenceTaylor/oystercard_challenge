class Oystercard
  MAXIMUM_CAPACITY = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(money)
    fail "you have reached top up capacity of £#{MAXIMUM_CAPACITY}" if full?
    @balance += money
  end

  def touch_in(station)
    fail "you don't have enough funds for a journey" unless enough_money?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private
  def full?
    @balance >= MAXIMUM_CAPACITY
  end

  def enough_money?
    @balance >= MINIMUM_FARE
  end

  def deduct(money)
    @balance -= money
  end
end
