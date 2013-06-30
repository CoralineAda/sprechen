class Conference::Search

  include Mongoid::Document

  field :topic

  has_and_belongs_to_many :events, :class_name => "Conference::Event"

  ROOT_URL = "http://lanyrd.com/topics/"

  after_create :get_events

  def results
    self.events.future.sorted
  end

  def get_events
    self.events = Conference::Event.from(HTTParty.get(url))
  end

  def prepared(topic)
    topic.to_s.downcase.gsub(" ","-")
  end

  def url
    "#{ROOT_URL}#{prepared(topic)}/#{prepared(topic)}.ics"
  end

end