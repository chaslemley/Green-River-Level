require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'haml'

post '/' do
  doc = Nokogiri::HTML(open('http://boatingbeta.com/runs/flows/green'))
  
  text = doc.at_css("p:nth-child(7)")
    
  @message = "Green Schedule" << "\n"
  
  [2,4,6].each do |index|
    if text.children[index]
      @message << "(#{Time.parse(text.children[index].text[0..9]).strftime('%a')}) #{text.children[index].text[14..-2]}" << "\n"
    end
  end

  content_type 'application/xml'
  haml :index
end

__END__

@@ index
!!! XML
%Response
  %Sms
    = @message