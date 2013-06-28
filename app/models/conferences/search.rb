class Conferences::Search

  include Mongoid::Document

  field :keyword

  has_and_belongs_to_many :events, :class_name => "Conferences::Event"

  ROOT_URL = "http://lanyrd.com/topics/"

  after_create :get_events

  def results
    self.events.future.sorted
  end

  def get_events
    self.events = Conferences::Event.from(HTTParty.get(url))
  end

  def prepared(keyword)
    keyword.to_s.downcase.gsub(" ","-")
  end

  def url
    "#{ROOT_URL}#{prepared(keyword)}/#{prepared(keyword)}.ics"
  end

end