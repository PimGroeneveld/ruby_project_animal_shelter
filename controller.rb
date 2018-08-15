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

post "/all-pets/owner-save" do
  @adoption = Adoption.new(params)
  @adoption.save
  @adoption.owner.buy_pet(@adoption.pet.cost)
  erb(:owner_save)
end

#DELETE ALL
post "/all-pets/delete-all" do
  Pet.delete_all()
  erb(:delete_all)
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

#EDIT pets info
get "/all-pets/:id/edit" do
  @pet = Pet.find(params[:id])
  erb(:edit)
end

 #update still not fully working, messing up order of updated info
#UPDATE pets info
post "/all-pets/:id" do
  @pet = Pet.new(params)
  @pet.update
  erb(:update)
end

#Match up pet to owner
get "/all-pets/:id/match-to-owner" do
  @owners = Owner.all()
  @pets = Pet.all()
  erb(:match_to_owner)
end

#--- owners
get "/home/owners" do
  @owners = Owner.all()
  erb(:new_owner)
end

get "/home/owners/new-owner" do
  erb(:new_owner_save)
end

post "/home/owners" do
  @owner = Owner.new(params)
  @owner.save
  erb(:create_owner)
end

post "/home/owners/delete-all" do
  Owner.delete_all()
  erb(:delete_all_owners)
end
