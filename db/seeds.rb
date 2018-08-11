require("pry")
# require_relative("../models/pizza_order")
# require_relative("../models/customer")

# PizzaOrder.delete_all()
# Customer.delete_all()

customer1 = Customer.new({
  'first_name' => 'Jack',
  'last_name' => 'Jarvis'
  })

customer1.save()


binding.pry
nil
