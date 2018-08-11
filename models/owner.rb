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


end
