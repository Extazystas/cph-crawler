require 'mechanize'

class ArrivalCrawler < ScheduleCrawler
  def self.perform
    super('https://www.cph.dk/en/flight-information/arrivals/')
  end
end
