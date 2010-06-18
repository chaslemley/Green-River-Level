require 'rubygems'
require 'sinatra'

require File.join(File.dirname(__FILE__), 'authorization.rb')
require File.join(File.dirname(__FILE__), 'settings.rb')


post '/' do
  login_required
end