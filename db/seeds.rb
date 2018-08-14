require("pry")
require_relative("../models/owner")
require_relative("../models/pet")
require_relative("../models/adoption")

Owner.delete_all()
Pet.delete_all()
Adoption.delete_all()

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

owner4 = Owner.new({
  'name' => 'Pim Groeneveld',
  'funds' => 200
  })

owner1.save()
owner2.save()
owner3.save()
owner4.save()

pet1 = Pet.new({
  'name' => 'Patch',
  'type' => 'Dog',
  'breed' => 'Dalmatian',
  'age' => '1',
  'size' => 'big',
  'sex' => 'male',
  'admission_date' => 20180825,
  'adoptable' => false,
  'cost' => 300,
  'picture' => 'images/dalmatian.jpg'
  })

pet2 = Pet.new({
  'name' => 'Garfield',
  'type' => 'Cat',
  'breed' => 'Tabby',
  'age' => '12',
  'size' => 'small',
  'sex' => 'male',
  'admission_date' => 20180810,
  'adoptable' => false,
  'cost' => 200,
  'picture' => 'images/garfield.jpg'
  })

pet3 = Pet.new({
  'name' => 'Snowball (formerly known as Snuffels)',
  'type' => 'Dog',
  'breed' => 'Maltese',
  'age' => '5',
  'size' => 'small',
  'sex' => 'male',
  'admission_date' => 20180720,
  'adoptable' => true,
  'cost' => 400,
  'picture' => 'images/Snuffles.jpg'
  })

pet4 = Pet.new({
  'name' => 'Grumpy',
  'type' => 'Cat',
  'breed' => 'Domestic',
  'age' => '7',
  'size' => 'small',
  'sex' => 'female',
  'admission_date' => 20180515,
  'adoptable' => true,
  'cost' => 800,
  'picture' => 'images/grumpycat.png'
  })

pet5 = Pet.new({
  'name' => 'Greyfriars Bobby',
  'type' => 'Dog',
  'breed' => 'Skye Terrier',
  'age' => '15',
  'size' => 'small',
  'sex' => 'male',
  'admission_date' => 20050220,
  'adoptable' => true,
  'cost' => 100,
  'picture' => 'images/bobby.png'
  })

pet1.save()
pet2.save()
pet3.save()
pet4.save()
pet5.save()

adoption1 = Adoption.new({
  "owner_id" => owner1.id,
  "pet_id" => pet3.id
  })

adoption2 = Adoption.new({
  "owner_id" => owner2.id,
  "pet_id" => pet4.id
  })

adoption3 = Adoption.new({
  "owner_id" => owner2.id,
  "pet_id" => pet2.id
  })

adoption4 = Adoption.new({
  "owner_id" => owner3.id,
  "pet_id" => pet1.id
  })

adoption1.save()
adoption2.save()
adoption3.save()
adoption4.save()

binding.pry
nil
