class Journey

  attr_reader :entry_station, :journey

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @journey = {entry_station => nil}
  end

  def finish_journey(exit_station)
    @journey[@entry_station] = exit_station
    @entry_station = nil
  end
end
