require File.dirname(__FILE__) + '/spec_helper'

describe 'Url Shortener' do
  def app
    @app ||= Sinatra::Application
  end
  
  context "creating short urls" do
    context "with invalid login" do
      it "should not allow url to be posted without authentication" do
        post '/', { :url => 'http://example.com' }
        last_response.status.should == 401
      end
    end
  end
end