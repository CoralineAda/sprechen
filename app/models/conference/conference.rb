require "geocoder/models/mongoid"

class Conference::Conference

  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  field :name
  field :summary
  field :location
  field :url
  field :start_date,  :type => Date
  field :end_date,    :type => Date
  field :coordinates, :type => Array
  field :address
  field :city
  field :state
  field :country

  reverse_geocoded_by :coordinates do |obj, results|
    if geo = results.first
      obj.city    = geo.city
      obj.state   = geo.state
      obj.country = geo.country
    end
  end

  belongs_to :user
  has_many :proposals, :class_name => 'Talk::Proposal'
  before_create :reverse_geocode

  # Class Methods ==============================================================

  def self.find_or_create(entry)
    where(:name => entry[:name]).first || create(entry)
  end

  def self.from(ics)
    return [] unless ics
    extracted_entries(ics).inject([]){ |a, entry| a << find_or_create(IcsParser.new(entry).parse!); a}
  end

  def self.extracted_entries(ics)
    IcsParser.entries_from(ics)
  end

  def self.future
    where(:start_date.gte => Date.today)# + 1.month)
  end

  def self.sorted
    asc(:start_date)
  end

  def self.todo
    upcoming.select{|conf| conf.proposals.empty? }
  end

  def self.upcoming
    where(:start_date.gt => Date.today.end_of_day)
  end

  # Instance Methods ===========================================================

  def end_date
    self[:end_date] || self.start_date || Date.today
  end

  def sanitized_location
    [self.city, self.state, self.country].compact.join(', ')
  end

  def sanitized_summary
    self.summary.split("\\n")[0].gsub('\\','')
  end

  def tags
    [self.country, self.start_date.year.to_s].compact
  end

end