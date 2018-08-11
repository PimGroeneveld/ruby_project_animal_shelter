require('pg')
require_relative("../db/sql_runner.rb")

class Adoption

  attr_accessor :pets, :adoption_fee
  attr_reader :id, :owner_id, :pet_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @owner_id = options['owner_id'].to_i
    @pet_id = options['pet_id'].to_i
    @adoption_fee = options['adoption_fee'].to_i
    @pets = []
  end

  #CREATE
  def save()
    sql = "INSERT INTO adoptions (
    owner_id,
    pet_id,
    adoption_fee
    )
    VALUES ($1, $2, $3)
    RETURNING *"
    values = [@owner_id, @pet_id, @adoption_fee]
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

  def update()
    sql = "UPDATE adoptions
    SET (
      owner_id,
      pet_id,
      adoption_fee
    ) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@owner_id, @pet_id, @adoption_fee]
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


end