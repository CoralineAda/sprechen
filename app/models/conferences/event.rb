class Conferences::Event

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :summary
  field :location
  field :url
  field :start_date,  :type => Date
  field :end_date,    :type => Date

  has_many :proposals

  def self.from(ics)
    return [] unless ics
    IcsParser.entries_from(ics).inject([]){ |a, entry| a << find_or_create(IcsParser.new(entry).parse!)}
  end

  def self.find_or_create(entry)
    where(:name => entry[:name]).first || create(entry)
  end

  def self.upcoming
    where(:start_date.gt => Date.today.end_of_day)
  end

  def self.todo
    upcoming.select{|conf| conf.proposals.empty? }
  end

  def end_date
    self[:end_date] || self.start_date || Date.today
  end

  def sanitized_summary
    self.summary.split("\\n")[0].gsub('\\','')
  end

end
