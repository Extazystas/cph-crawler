require 'mechanize'

class ScheduleCrawler
  def self.perform(url)
    result = []
    agent = Mechanize.new

    agent.get(url) do |page|
      page.search('.stylish-table__row.stylish-table__row--body').each do |row|
         result << {
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
    end
    result
  rescue SocketError => e
    { status: 'error', message: 'Eror: No Internet connection.' }
  end

  private

  def self.parse_text(row, selector, index = 0)
    row.search(selector)[index].text.strip
  end
end
