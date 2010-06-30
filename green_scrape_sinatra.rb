require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'haml'

post '/' do
  url = 'http://boatingbeta.com/runs/flows/green'
  doc = Nokogiri::HTML(open(url))
  
  text = doc.at_css("p:nth-child(7)")
  
  @message = "Green Schedule" << "\n"
  @message << "(#{Time.parse(text.children[2].text[0..9]).strftime('%a')}) #{text.children[2].text[27..-2]}" << "\n"
  @message << "(#{Time.parse(text.children[4].text[0..9]).strftime('%a')}) #{text.children[4].text[27..-2]}" << "\n"
  @message << "(#{Time.parse(text.children[6].text[0..9]).strftime('%a')}) #{text.children[6].text[27..-2]}" << "\n"
  
  @message
  content_type 'application/xml'
  
  haml :index
end

__END__

@@ index
!!! XML
%Response
  %Sms
    = @message

