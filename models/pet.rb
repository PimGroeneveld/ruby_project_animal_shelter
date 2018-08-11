require('pg')
require_relative("../db/sql_runner.rb")

class Pet

  attr_accessor :name, :type, :breed, :age, :size, :sex, :admission_date, :trained, :cost
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @breed = options['breed']
    @age = options['age'].to_i
    @size = options['size']
    @sex = options['sex']
    @admission_date = options['admission_date']
    @trained = options['trained']
    @cost = options['cost']
  end

  #CREATE
  def save()
    sql = "INSERT INTO pets (
    name,
    type,
    breed,
    age,
    size,
    sex,
    admission_date,
    trained,
    cost
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    RETURNING *"
    values = [@name, @type, @breed, @age, @size, @sex, @admission_date, @trained, @cost]
    pet_info = SqlRunner.run(sql, values)
    @id = pet_info.first()['id'].to_i
  end

  #READ
  def self.all()
    sql = "SELECT * FROM pets"
    pets = SqlRunner.run(sql)
    result = pets.map{|pet| Pet.new(pet)}
    return result
  end

  #READ
  def self.find(id)
    sql = "SELECT * FROM pets WHERE id = $1"
    values = [id]
    pet = SqlRunner.run(sql, values)
    result = Pet.new(pet.first)
    return result
  end

  #UPDATE   --> same as with owners but now: "PG::ProtocolViolation: ERROR:  bind message supplies 2 parameters, but prepared statement "query" requires 10"
  def update()
    sql = "UPDATE pets
    SET (
      name,
      type,
      breed,
      age,
      size,
      sex,
      admission_date,
      trained,
      cost
    ) =
    ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    WHERE id = $10"
    values = [@name, @type, @breed, @age, @size, @sex, @admission_date, @trained, @cost]
    SqlRunner.run( sql, values )
  end

  #DELETE
  def self.delete_all()
    sql = "DELETE FROM pets"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM pets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end
  #----------
  #list pets and admission date
  def name_admission
    return"#{@name} arrived here on #{@admission_date}"
  end


end
