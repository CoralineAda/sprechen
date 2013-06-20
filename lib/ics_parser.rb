class IcsParser

  attr_accessor :event

  def initialize(ics_file)
    self.event = ics_file.split(/[\n\r]/)
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

  def description
    parse_attr('description')
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
      :summary => summary,
      :location => location,
      :url => url,
      :description => description,
      :start_date => Date.parse(start_date),
      :end_date => Date.parse(end_date)
    }
  end

end