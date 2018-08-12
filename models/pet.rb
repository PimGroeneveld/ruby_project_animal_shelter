require('pg')
require_relative("../db/sql_runner.rb")
require 'date'

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
  #list pet and admission date
  def name_admission()
    return"#{@name} arrived here on #{@admission_date}"
  end

  # Lists all pets and their admission date as ruby objects
  def self.all_pets_admission()
    sql = "SELECT name, admission_date FROM pets"
    pets_incl_admission = SqlRunner.run(sql)
    result = pets_incl_admission.map{|pet| Pet.new(pet)}
    return result
  end

  #working in terminal, not in sinatra. Continue on Monday. is the .to_i even needed? seems to solve the error but then still not display anything
  def ready_adoption()
    @end_date = @admission_date.to_i + 14
    return "Yes" if @trained == true
    return "Not yet, will be available on #{@end_date}" if @trained == false
  end

  #list owner for pet
  def list_owner()
    sql = "SELECT * FROM owners INNER JOIN adoptions ON owners.id = adoptions.owner_id WHERE adoptions.pet_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return result
  end

  #version to mess around in --> wanted to create a scenario in which the @trained is obsolete and would get marked ready for adoption immediately after the two weeks have passed. Now it is more realistic though, some pets might take longer to train and thus wont accidently get marked as adoptable without human intervention

  # def ready_adoption()
  #   start_date = @admission_date
  #   @end_date = @admission_date + 14
  #   return "Yes" if @admission_date < @end_date
  #   return "Not yet, will be available on #{@end_date}" if @admission_date >= @end_date
  # end


end
