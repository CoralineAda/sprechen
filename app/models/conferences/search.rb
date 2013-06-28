class Conferences::Search

  include Mongoid::Document

  field :keyword

  ROOT_URL = "http://lanyrd.com/topics/"

  def results
    @results ||= Conferences::Event.from(HTTParty.get(url)).sort{|a,b| a.name <=> b.name}
  end

  def prepared(keyword)
    keyword.to_s.downcase.gsub(" ","-")
  end

  def url
    "#{ROOT_URL}#{prepared(keyword)}/#{prepared(keyword)}.ics"
  end

end