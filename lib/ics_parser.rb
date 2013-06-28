class IcsParser

  attr_accessor :event

  def self.entries_from(calendar)
    calendar.gsub(/^.?BEGIN:VEVENT/, 'BEGIN:VEVENT').split("BEGIN:VEVENT")[1..-1]
  end

  def initialize(ics_file)
    self.event = ics_file.split(/[\n\r]/)
  end

  def name
    parse_attr('summary')
  end

  def summary
    parse_attr('description')
  end

  def location
    parse_attr('location')
  end

  def url
    parse_attr('url')
  end

  def start_date
    parse_attr('dtstart')
  end

  def end_date
    parse_attr('dtend')
  end

  def parse_attr(attr)
    match = self.event.select{|l| l =~ /^#{attr}/i}.first.to_s.split(':')[1..-1] || []
    match.join('')
  end

  def parse!
    {
      :name => name,
      :summary => summary,
      :location => location,
      :url => url,
      :start_date => Date.parse(start_date.to_s),
      :end_date => Date.parse(end_date.to_s)
    }
  end

end