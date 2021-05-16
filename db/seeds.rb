example_user = User.create(email: 'user@email.com', password: 'abc123', name: 'Olivia Lobo')
User.create(email: 'admin@pet-finder.com', password: 'abc123', name: 'ConnectPlus', admin: true)

Pet.create(name: 'Adelaide', species: :cat, sex: :female, breed: 'SRD', color: 'Preto', image: Faker::Avatar.image(slug: '1'),
           details: 'Gata companheira mansa de olhos verdes', city: 'Sao Paulo', state: 'SP', status: :found,
           active: true, user: example_user)
Pet.create(name: 'Lyra', species: :cat, sex: :female, breed: 'SRD', color: 'Branco', image: Faker::Avatar.image(slug: '2'),
           details: 'Gata filhote de pelo claro', city: 'Sao Paulo', state: 'SP', status: :lost,
           active: true, user: example_user)
Pet.create(name: 'Lili', species: :cat, sex: :female, breed: 'Siames', color: 'Bege', image: Faker::Avatar.image(slug: '3'),
           details: 'Gata siamesa desconfiada', city: 'Sao Paulo', state: 'SP', status: :found,
           active: true, user: example_user)
Pet.create(name: 'Link', species: :dog, sex: :male, breed: 'Lhasa apso', color: 'White', image: Faker::Avatar.image(slug: '4'),
           details: 'Bom cachorro', city: 'Sao Paulo', state: 'SP', status: :lost,
           active: true, user: example_user)
Pet.create(name: 'Rex', species: :dog, sex: :male, breed: 'Pastor alemão', color: 'Marrom', image: Faker::Avatar.image(slug: '5'),
           details: 'Cachorro grande e alerta', city: 'Sao Paulo', state: 'SP', status: :lost,
           active: true, user: example_user)
Pet.create(name: 'Susan', species: :dog, sex: :female, breed: 'Pinscher', color: 'Marrom', image: Faker::Avatar.image(slug: '6'),
           details: 'Bom cachorro', city: 'Sao Paulo', state: 'SP', status: :lost,
           active: false, user: example_user)