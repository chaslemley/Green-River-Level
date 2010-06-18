set :authorization_realm, "Protected zone"

configure :development do
  set :login, 'admin'
  set :password, 'secret'
end

configure :test do
  set :login, 'admin'
  set :password, 'secret'
end

configure :production do
  set :login, 'admin'
  set :password, 'secret'
end