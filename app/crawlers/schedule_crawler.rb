require 'mechanize'

class ScheduleCrawler
  ITEM_ROW_SELECTOR = '.stylish-table__row.stylish-table__row--body'

  def self.perform(url)
    result = []
    agent  = Mechanize.new

    agent.get(url) do |page|
      page.search(ITEM_ROW_SELECTOR).each do |row|
        result << build_scheduled_object(row)
      end
    end
    result
  end

  private

  class << self
    def build_scheduled_object(row)
      {
        time: parse_text(row, '.stylish-table__cell.flights__table__col--time'),
        expected_time: parse_text(row, '.stylish-table__cell.v--desktop-only'),
        airline_name: parse_text(row, '.stylish-table__cell.v--desktop-only', 1),
        destination: parse_text(row, '.stylish-table__cell.flights__table__col--destination span strong span'),
        flight_no: parse_text(row, '.stylish-table__cell.flights__table__col--destination span small'),
        terminal: parse_text(row, '.stylish-table__cell.flights__table__col--terminal'),
        gate: parse_text(row, '.stylish-table__cell.flights__table__col--gate'),
        status: parse_text(row, '.stylish-table__cell div span', -2)
      }
    end

    def parse_text(row, selector, index = 0)
      row.search(selector)[index].text.strip
    end
  end
end
