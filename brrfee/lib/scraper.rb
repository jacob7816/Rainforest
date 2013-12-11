require 'open-uri'
require 'nokogiri'
require 'sanitize'

class Scraper

	def initialize(url_to_scrape)
		@url = url_to_scrape
	end

	def scrape
		# TO DO: change to JSON
		# page = Nokogiri::HTML(open(@url)) 
		puts "Initiating scrape..."
		raw_response = open(@url)
		json_response = JSON.parse(raw_response.read)
		page = Nokogiri::HTML(json_response["html"]) 

		# your page should now be a hash. You need the page["html"]

		# Change this to parse the a tags with the class "article_title"
		# and build the links array for each href in these article_title links
		puts "Scraping links..."
		links = page.css(".article_title")
		articles = []

		# everything else here should work fine.
		# Limit the number of links to scrape for testing phase
		puts "Building articles collection..."
		links.each do |link|
			article_url = "http://seekingalpha.com" + link["href"]
			article_page = Nokogiri::HTML(open(article_url))
			article = {}
			article[:company] = article_page.css("#about_primary_stocks").css("a")
			article[:content] = article_page.css("#article_content")
			article[:content] = Sanitize.clean(article[:content].to_s)
			unless article[:content].blank?
				articles << article
			end
		end

		puts "Clearing all existing transcripts..."
		Transcript.destroy_all
		# Iterate over the articles collection and save each record into the database
		puts "Saving new transcripts..."
		articles.each do |article|
			transcript = Transcript.new
			transcript.stock_symbol = article[:company].text.to_s
			transcript.content = article[:content].to_s
			transcript.save
		end

		#return articles
	end

end