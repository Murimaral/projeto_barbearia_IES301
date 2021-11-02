if Pet.count.zero?
  example_user = User.create(email: 'user@email.com', password: 'abc123', name: 'Olivia Lobo', phone: '(11) 987654321')
  admin = User.create(email: 'admin@barbershop.com', password: 'abc123', name: 'ConnectPlus', admin: true, phone: '(11) 912345678')
  User.create(email: 'leticia@cta.com.br', password: 'admin000', name: 'Mayumi', admin: true, phone: '(11) 123456789')
  User.create(email: 'lucas@cta.com.br', password: 'admin000', name: 'Lucas', admin: true, phone: '(11) 931233213')

  0.times do
    location = Locations::STATES.sample
    species = ['cat', 'dog'].sample
    pet = Pet.create(name: Faker::Creature::Dog.name, species: species, sex: ['male', 'female'].sample, breed: species == 'cat' ? Breeds::CAT_BREEDS.sample : Breeds::DOG_BREEDS.sample,
                     color: Colors::COLORS.keys.sample, details: Faker::Lorem.paragraph, city: location[:cities].sample, state: location[:name], status: ['found', 'lost'].sample,
                     active: true, user: User.first)
    generated_image = File.open('app/assets/images/paw.jpg')
    pet.image.attach(io: generated_image, filename: 'avatar.jpg')
  end
end
