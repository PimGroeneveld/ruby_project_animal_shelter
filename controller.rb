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

#SHOW
get "/all-pets/:id" do
  @pet = Pet.find(params[:id])
  erb(:show)
end

#DELETE
post "/all-pets/:id/delete" do
  @pet = Pet.find(params[:id])
  @pet.delete
  redirect "/all-pets"
end

#EDIT
get "/all-pets/:id/edit" do
  @pet = Pet.find(params[:id])
  erb(:edit)
end

 #update still not fully working due to the class method not working, ask about after finishing mvp
#UPDATE
post "/all-pets/:id" do
  @pet = Pet.new(params)
  @pet.update
  erb(:update)
end

#from index:
#<!-- <p> Ready for adoption: <%= pet.ready_adoption%></p> -->
