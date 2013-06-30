namespace :topics do

  desc "Reload topics from Lanyrd"
  task :load => :environment do
    scraper = TopicScraper.new(:root_sitemap => "http://lanyrd.com/sitemap.xml" )
    scraper.topics.each do |topic|
      Conference::Topic.where(:name => topic).empty? && Conference::Topic.create(:name => topic)
    end
  end

end