namespace :topics do

  desc "Reload topics from Lanyrd"
  task :load => :environment do
    scraper = TopicScraper.new(:root_sitemap => "http://lanyrd.com/sitemap.xml" )
    scraper.topics.each do |topic|
      Topic.where(:name => topic).empty? && Topic.create(:name => topic)
    end
  end

end