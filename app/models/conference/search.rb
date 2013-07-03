class Conference::Search

  include Mongoid::Document

  field :topic

  has_and_belongs_to_many :conferences, :class_name => "Conference::Conference"

  ROOT_URL = "http://lanyrd.com/topics/"

  after_create :get_conferences

  def results
    self.conferences.future.sorted
  end

  def get_conferences
    self.conferences = Conference::Conference.from(HTTParty.get(url))
  end

  def prepared(topic)
    topic.to_s.downcase.gsub(" ","-")
  end

  def url
    "#{ROOT_URL}#{prepared(topic)}/#{prepared(topic)}.ics"
  end

end