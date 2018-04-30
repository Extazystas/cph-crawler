class DepartureCrawler < ScheduleCrawler
  def self.perform
    super('https://www.cph.dk/en/flight-information/departures/')
  end
end
