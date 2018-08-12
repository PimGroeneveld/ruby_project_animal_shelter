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

#not working yet
get "/matched-owners" do
  @owners_pets = Adoption.show_all_matches()
  erb(:matches)
end

# get "/matched-owners" do
#   @owners = Adoption.owner()
#   @pets = Adoption.pet()
#   erb(:matches)
# end
