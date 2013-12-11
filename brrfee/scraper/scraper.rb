require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'debugger'

page = Nokogiri::XML(open("http://seekingalpha.com/tag/transcripts.xml"))  
links = page.xpath("//link")
articles = []
links.each do |link|
	article = Nokogiri::HTML(open(link))
	article_content = article.css("#article_content")
	articles << article_content
end
puts articles

