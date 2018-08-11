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
    result = pets.map{|pet| Pet.new(pet)}
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

  #UPDATE  --> error: "PG::ProtocolViolation: ERROR:  bind message supplies 2 parameters, but prepared statement "query" requires 3"
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
    values = [@name, @funds]
    SqlRunner.run( sql, values )
  end

  #DELETE
  def self.delete_all()
    sql = "DELETE FROM owners"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM owners
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end




  # #  To buy pets  --> still needs modifying, this is the film example
  # def buy_all_tickets()
  #   sql = "SELECT SUM (pets.price) FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
  #   values = [@id]
  #   result = SqlRunner.run(sql, values).first
  #   @funds = @funds - result['sum'].to_i
  # end


end
