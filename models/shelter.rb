require('pg')
require_relative("../db/sql_runner.rb")

class Shelter

  attr_accessor :name, :owner, :pets, :till
  attr_reader :id, :owner_id, :pet_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @owner = options['owner']
    @pets = []
    @till = options['till'].to_i
    @owner_id = options['owner_id'].to_i
    @pet_id = options['pet_id'].to_i
  end


end
