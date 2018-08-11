require("pry")
require_relative("../models/owner")
require_relative("../models/pet")
require_relative("../models/adoption")

Owner.delete_all()
Pet.delete_all()
# Adoption.delete_all()

owner1 = Owner.new({
  'name' => 'Doolittle',
  'funds' => 500
  })

owner2 = Owner.new({
  'name' => 'Freddie Mercury',
  'funds' => 2000
  })

owner3 = Owner.new({
  'name' => 'Cruella De Vil',
  'funds' => 1000
  })

owner1.save()
owner2.save()
owner3.save()

pet1 = Pet.new({
  'name' => 'Patch',
  'type' => 'Dog',
  'breed' => 'Dalmatian',
  'age' => '1',
  'size' => 'big',
  'sex' => 'male',
  'admission_date' => 20180806,
  'trained' => false,
  'cost' => 300
  })

pet2 = Pet.new({
  'name' => 'Garfield',
  'type' => 'Cat',
  'breed' => 'Tabby',
  'age' => '12',
  'size' => 'small',
  'sex' => 'male',
  'admission_date' => 20180804,
  'trained' => false,
  'cost' => 200,
  })

pet3 = Pet.new({
  'name' => 'Snowball',
  'type' => 'Dog',
  'breed' => 'Maltese',
  'age' => '5',
  'size' => 'small',
  'sex' => 'male',
  'admission_date' => 20180720,
  'trained' => true,
  'cost' => 400
  })

pet4 = Pet.new({
  'name' => 'Grumpy',
  'type' => 'Cat',
  'breed' => 'Domestic',
  'age' => '7',
  'size' => 'small',
  'sex' => 'female',
  'admission_date' => 20180515,
  'trained' => true,
  'cost' => 800
  })

pet1.save()
pet2.save()
pet3.save()
pet4.save()

# adoption_fee is just a random number now, want to adjust this so it reflects the cost of the pet
adoption1 = Adoption.new({
  "owner_id" => owner1.id,
  "pet_id" => pet3.id,
  "adoption_fee" => 20
  })

adoption2 = Adoption.new({
  "owner_id" => owner2.id,
  "pet_id" => pet4.id,
  "adoption_fee" => 20
  })

adoption3 = Adoption.new({
  "owner_id" => owner2.id,
  "pet_id" => pet2.id,
  "adoption_fee" => 20
  })

adoption1.save()
adoption2.save()
adoption3.save()

binding.pry
nil
