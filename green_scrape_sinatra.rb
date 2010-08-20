require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'haml'

post '/' do
  doc = Nokogiri::HTML(open('http://boatingbeta.com/runs/flows/green'))
  
  text = doc.at_css("p:nth-child(7)")
      
  [2,4,6].each do |index|
    if text.children[index]
      day_of_week = Time.parse(text.children[index].text[0..9]).strftime('%a')
      release_text = text.children[index].text[14..-2]
      @message << "(#{day_of_week}) #{release_text}" << "\n"
    end
  end
  
  lake_level = "99.5"
  
  @message << "Lake Level: #{lake_level}"

  content_type 'application/xml'
  haml :index
end

get '/' do
  doc = Nokogiri::HTML(open('http://boatingbeta.com/runs/flows/green'))
  
  text = doc.at_css("p:nth-child(7)")
      
  [2,4,6].each do |index|
    if text.children[index]
      day_of_week = Time.parse(text.children[index].text[0..9]).strftime('%a')
      release_text = text.children[index].text[14..-2]
      @message << "(#{day_of_week}) #{release_text}" << "\n"
    end
  end
  
  lake_level = "99.5"
  
  @message << "Lake Level: #{lake_level}"

  content_type 'application/xml'
  haml :index
end

__END__

@@ index
!!! XML
%Response
  %Sms
    = @message