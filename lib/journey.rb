class Journey

  attr_reader :entry_station, :journey

  def initialize(entry_station)
    @entry_station = entry_station
    @journey = {entry_station => nil}
  end
end
