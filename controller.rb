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

get "/all-pets/new-pet" do
  erb(:newpet)
end

get "/tips" do
  erb(:tips)
end

get "/contact" do
  erb(:contact)
end

#not working yet
get "/matched-owners" do
  @adoptions = Adoption.all()
  erb(:matches)
end

#CREATE
post "/all-pets" do
  @pet = Pet.new(params)
  @pet.save
  erb(:create)
end


#from index:
#<!-- <p> Ready for adoption: <%= pet.ready_adoption%></p> -->
