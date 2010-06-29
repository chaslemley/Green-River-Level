require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'

# url = 'http://boatingbeta.com/runs/flows/green'
# doc = Nokogiri::HTML(open(url))
# 
# text = doc.at_css("p:nth-child(7)")
# 
# puts "Green Schedule for Next 3 days"
# puts "Today (#{Time.parse(text.children[2].text[0..9]).strftime('%a')}): #{text.children[2].text[27..-2]}"
# puts "Tomorrow (#{Time.parse(text.children[4].text[0..9]).strftime('%a')}): #{text.children[4].text[27..-2]}"
# puts "In 2 days (#{Time.parse(text.children[6].text[0..9]).strftime('%a')}): #{text.children[6].text[27..-2]}"

get '/' do
  url = 'http://boatingbeta.com/runs/flows/green'
  doc = Nokogiri::HTML(open(url))
  
  text = doc.at_css("p:nth-child(7)")
  
  message = "Green Schedule for Next 3 days" << "<br />"
  message << "Today (#{Time.parse(text.children[2].text[0..9]).strftime('%a')}): #{text.children[2].text[27..-2]}" << "<br />"
  message << "Tomorrow (#{Time.parse(text.children[4].text[0..9]).strftime('%a')}): #{text.children[4].text[27..-2]}" << "<br />"
  message << "In 2 days (#{Time.parse(text.children[6].text[0..9]).strftime('%a')}): #{text.children[6].text[27..-2]}" << "<br />"
  
  message
end