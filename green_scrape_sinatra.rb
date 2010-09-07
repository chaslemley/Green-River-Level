require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'haml'

post '/' do
  doc = Nokogiri::HTML(open('http://boatingbeta.com/runs/flows/green'))
  
  text = doc.at_css("p:nth-child(7)")
    
  @message = ""
  
  [2,4,6].each do |index|
    if text.children[index]
      day_of_week = Time.parse(text.children[index].text[0..9]).strftime('%a')
      release_text = text.children[index].text[14..-2]
      @message << "#{day_of_week} #{release_text}" << "\n"
    end
  end
  
  lake_level = doc.at_css("p:nth-child(11) b:nth-child(1)").children[0].text
  
  @message << "Lake: #{lake_level}"

  content_type 'application/xml'
  haml :index
end

get '/' do
  doc = Nokogiri::HTML(open('http://boatingbeta.com/runs/flows/green'))
  
  text = doc.at_css("p:nth-child(7)")
  
  @message = ""
      
  [2,4,6].each do |index|
    if text.children[index]
      day_of_week = Time.parse(text.children[index].text[0..9]).strftime('%a')
      release_text = text.children[index].text[14..-2]
      @message << "(#{day_of_week}) #{release_text}" << "\n"
    end
  end

  lake_level = doc.at_css("p:nth-child(11) b:nth-child(1)").children[0].text
  
  @message << "Lake: #{lake_level}"

  content_type 'application/xml'
  haml :index
end

get '/donate' do
  haml :donate
end

__END__

@@ index
!!! XML
%Response
  %Sms
    = @message
    
@@ donate
!!!
%head
  %title Green River SMS Level
%body{:style => "text-align:center; font-family: Arial; margin-top: 240px"}
  %p{:style => "font-size: 20px"} To get the current green river 3 day release schedule, send a text message to <strong>(706) 403-4950</strong>
  %p{:style => "margin-top: 100px"} If you find this helpful, click the button below to donate $5, Thanks!
  %form{:action => "https://www.paypal.com/cgi-bin/webscr", :method => "post"}
    %input{:type => "hidden", :name => "cmd", :value => "_s-xclick"}
    %input{:type => "hidden", :name => "hosted_button_id", :value => "KQXZPLSAX9WNU" }
    %input{:type => "image", :src => "https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif", :border => "0", :name => "submit", :alt => "PayPal - The safer, easier way to pay online!"}
    %img{:alt => "", :border => "0", :src => "https://www.paypal.com/en_US/i/scr/pixel.gif", :width => "1", :height => "1"}
  %p{:style => "font-size: 10px; margin-top: 20px"} Standard text messaging rates apply.