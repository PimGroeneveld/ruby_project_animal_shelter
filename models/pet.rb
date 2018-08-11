require('pg')
require_relative("../db/sql_runner.rb")

class Pet

  attr_accessor :name, :funds, :pets
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


end
