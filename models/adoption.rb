require('pg')
require_relative("../db/sql_runner.rb")

class Adoption

  attr_accessor :pets
  attr_reader :id, :owner_id, :pet_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @owner_id = options['owner_id'].to_i
    @pet_id = options['pet_id'].to_i
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
      pet_id
    ) =
    ($1, $2)
    WHERE id = $3"
    values = [@owner_id, @pet_id, @id]
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

  #Show all adoptions as owner_id and pet_id
  def self.show_all_matches()
    sql = "SELECT adoptions.* FROM owners
    INNER JOIN adoptions ON owners.id = adoptions.owner_id
    INNER JOIN pets ON pets.id = adoptions.pet_id"
    result = SqlRunner.run(sql)
    return result.map{|adoption| Adoption.new(adoption)}
  end

  #Which owner belong to which owner_id
  def owner()
    sql = "SELECT * FROM owners WHERE id = $1"
    values  = [@owner_id]
    owner = SqlRunner.run(sql, values).first
    return Owner.new(owner)
  end

  #which pet belongs to which pet_id
  def pet()
    sql = "SELECT * FROM pets WHERE id = $1"
    values = [@pet_id]
    pet = SqlRunner.run(sql, values).first
    return Pet.new(pet)
  end


end
