require 'scraper'

namespace :brrfee do 
	task :scrape => :environment do
		(1..1200).each do |page|
			puts "Scraping page #{page}..."
			scraper = Scraper.new("http://seekingalpha.com/analysis/transcripts?page=#{page}")
			scraper.scrape
		end
	end
end