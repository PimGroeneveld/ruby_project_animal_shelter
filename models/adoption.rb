require('pg')
require_relative("../db/sql_runner.rb")

class Adoption

  attr_accessor :pets
  attr_reader :id, :owner_id, :pet_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @owner_id = options['owner_id'].to_i
    @pet_id = options['pet_id'].to_i
    @pets = []
  end

  #CREATE
  def save()
    sql = "INSERT INTO adoptions (
    owner_id,
    pet_id
    )
    VALUES ($1, $2)
    RETURNING *"
    values = [@owner_id, @pet_id]
    adopt_info = SqlRunner.run(sql, values)
    @id = adopt_info.first()['id'].to_i
  end

  #READ
  def self.all()
    sql = "SELECT * FROM adoptions"
    adoptions = SqlRunner.run(sql)
    result = adoptions.map{|adopt| Adoption.new(adopt)}
    return result
  end

  #READ
  def self.find(id)
    sql = "SELECT * FROM adoptions WHERE id = $1"
    values = [id]
    adopt = SqlRunner.run(sql, values)
    result = Adoption.new(adopt.first)
    return result
  end

  #UPDATE
  def update()
    sql = "UPDATE adoptions
    SET (
      owner_id,
      pet_id]
    ) =
    ($1, $2)
    WHERE id = $3"
    values = [@owner_id, @pet_id]
    SqlRunner.run( sql, values )
  end

  #DELETE
  def self.delete_all()
    sql = "DELETE FROM adoptions"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM adoptions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # --> insert update in here some how? and in adoption or pet class?
  # Even pets without any adoption should exist here under pet_id
  def assign_pet()
  

  end

  #Not working in terminal/sinatra but working in psql
  def self.show_all_matches()
    sql = "SELECT owners.name, pets.name FROM owners
    INNER JOIN adoptions ON owners.id = adoptions.owner_id
    INNER JOIN pets ON pets.id = adoptions.pet_id"
    result = SqlRunner.run(sql)
    return result
  end

  #Which owner belong to which owner_id
  def self.owner()
    sql = "SELECT * FROM owners WHERE id = $1"
    values  = [@owner_id]
    owner = SqlRunner.run(sql, values).first
    return Owner.new(owner)
  end

  #which pet belongs to which pet_id
  def self.pet()
    sql = "SELECT * FROM pets WHERE id = $1"
    values = [@pet_id]
    pet = SqlRunner.run(sql, values).first
    return Pet.new(pet)
  end


end
