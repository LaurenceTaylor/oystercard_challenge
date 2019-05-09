class Oystercard
  MAXIMUM_CAPACITY = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(money)
    fail "top up capacity hit: £#{MAXIMUM_CAPACITY}" if full?(money)

    @balance += money
  end

  def touch_in(station)
    fail "you don't have enough funds for a journey" unless enough_money?
    
    start_journey(station)
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    end_journey(station)
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private
  def start_journey(station)
    @journey_history << { station => nil }
  end

  def end_journey(station)
    @journey_history.last[@entry_station] = station
  end

  def full?(money)
    @balance + money > MAXIMUM_CAPACITY
  end

  def enough_money?
    @balance >= MINIMUM_FARE
  end

  def deduct(money)
    @balance -= money
  end
end
