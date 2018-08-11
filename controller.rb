require('pry-byebug')
require('sinatra')
require('sinatra/contrib/all')

require_relative ('./models/owner')
require_relative ('./models/pet')
require_relative ('./models/adoption')
also_reload ('./models/*')

get "/home" do
  erb(:home)
end

get "/all-pets" do
  @pets = Pet.all()
  erb(:index)
end

get "/tips" do
  erb(:tips)
end

get "/contact" do
  erb(:contact)
end
