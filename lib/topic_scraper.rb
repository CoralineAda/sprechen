require 'open-uri'
require 'nokogiri'

class TopicScraper

  attr_accessor :root_sitemap

  def initialize(args={})
    args.each{|k,v| self.send("#{k}=",v) if self.respond_to?(k)}
  end

  def topics
    topic_maps.map{|m| m.xpath('//urlset/url/loc').map{|n| n.content.split('/')[-2]}}.flatten.uniq.sort.map{|t| t.gsub("-", " ")}
  end

  private

  def sitemap
    @sitemap ||= Nokogiri::HTML(open(self.root_sitemap))
  end

  def topic_nodes
    sitemap.xpath('//sitemap/loc').select{|n| n.content =~ /topic/}
  end

  def topic_maps
    topic_nodes.inject([]){ |a,n| a << Nokogiri::HTML(open(n.content))}
  end

end