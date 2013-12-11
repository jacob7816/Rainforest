class ScraperController < ApplicationController
  
	#require 'scraper'
	require 'csv'

  def index
  	#scraper = Scraper.new("http://seekingalpha.com/analysis/transcripts?page=1")
  	#@articles = scraper.scrape
    @transcripts = Transcript.all.limit(40)

  	# CSV.open("/Users/tharris/Desktop/brrfee/content.csv", "wb") do |csv|
  	#  	@articles.each do |article|
  	#  		csv << [article[:company].text.to_s, article[:content].to_s]
  	#  	end
  	# end
  end

end


# Change the url where we're request data to http://seekingalpha.com/analysis/transcripts?page=1 (2, 3, 4, etc.)
# Our new url uses JSON instead of XML, so we need to change which data format our scraper works with
# The new data format gives us our full HTML under "html:", and also gives us the total page count as "page_count:" (approx. 1287)
# Once we get the HTML, we need to use Nokogiri to select all the links with the "article_title" class.
# From there, we need to find the value of each for the href attribute and put it into the links array

