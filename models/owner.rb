require('pg')
require_relative("../db/sql_runner.rb")

class Owner

  attr_accessor :name, :funds, :pets
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
    @pets = []
  end

  #CREATE
  def save()
    sql = "INSERT INTO owners (
    name,
    funds
    )
    VALUES ($1, $2)
    RETURNING *"
    values = [@name, @funds]
    owner_info = SqlRunner.run(sql, values)
    @id = owner_info.first()['id'].to_i
  end

  #READ
  def self.all()
    sql = "SELECT * FROM owners"
    pets = SqlRunner.run(sql)
    result = pets.map{|pet| Owner.new(pet)}
    return result
  end

  #READ
  def self.find(id)
    sql = "SELECT * FROM owners WHERE id = $1"
    values = [id]
    owner = SqlRunner.run(sql, values)
    result = Owner.new(owner.first)
    return result
  end

  #UPDATE
  def update()
    sql = "UPDATE owners
    SET
    (
      name,
      funds
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run( sql, values )
  end

  #DELETE
  def self.delete_all()
    sql = "DELETE FROM owners"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM owners WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  #list all adopted pets per owner  --> class method (not working yet) #not being used atm
  def self.list_adopted_pets(id)
    sql = "SELECT * FROM pets INNER JOIN adoptions ON pets.id = adoptions.pet_id WHERE adoptions.owner_id = $1"
    values = [id]
    pets = SqlRunner.run(sql, values)
    return pets.map{|pet| Pet.new(pet)}
  end

  #instance method -> working for individual owners
  def list_adopted_pets()
    sql = "SELECT * FROM pets INNER JOIN adoptions ON pets.id = adoptions.pet_id WHERE adoptions.owner_id = $1"
    values = [@id]
    pets = SqlRunner.run(sql, values)
    return pets.map{|pet| Pet.new(pet)}
  end

  #To buy pets --> deducts the cost of the pet from their funds
  def buy_pet()
    sql = "SELECT SUM (pets.cost) FROM pets INNER JOIN adoptions ON pets.id = adoptions.pet_id WHERE adoptions.owner_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    @funds = @funds - result['sum'].to_i
  end

end
