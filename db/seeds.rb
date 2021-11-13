if Pet.count.zero?
  User.create(email: 'user@email.com', password: 'abc123', name: 'Olivia Lobo', phone: '(11) 987654321')
  User.create(email: 'admin@barbershop.com', password: 'abc123', name: 'ConnectPlus', admin: true, phone: '(11) 912345678')
  Customer.create(email: 'leticia@cta.com.br', name: 'Mayumi', phone: '(11) 123456789', details: 'oi descriçao')
  Customer.create(email: 'lucas@cta.com.br', name: 'Lucas', phone: '(11) 931233213', details: 'primo da Adelaide')

  0.times do
    location = Locations::STATES.sample
    species = ['cat', 'dog'].sample
    pet = Pet.create(name: Faker::Creature::Dog.name, species: species, sex: ['male', 'female'].sample, breed: species == 'cat' ? Breeds::CAT_BREEDS.sample : Breeds::DOG_BREEDS.sample,
                     color: Colors::COLORS.keys.sample, details: Faker::Lorem.paragraph, city: location[:cities].sample, state: location[:name], status: ['found', 'lost'].sample,
                     active: true, user: User.first)
    generated_image = File.open('app/assets/images/paw.jpg')
    pet.image.attach(io: generated_image, filename: 'avatar.jpg')
  end


  5.times do
    Employee.create(
      name: Faker::Name.unique.name,
      phone: Faker::PhoneNumber.unique.phone_number,
      gender: ['male', 'female'].sample,
      email: Faker::Internet.email,
      document: Faker::Kpop.girl_groups,
      address: Faker::Address.full_address,
      birthdate: Faker::Date.birthday(min_age: 18, max_age: 65)
    )
  end

  5.times do
    Service.create(name: Faker::Job.title)
  end
end
