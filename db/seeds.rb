if User.count.zero?
  User.create(email: 'admin@luzdomundo.com.br', password: 'abc123', name: 'Cristian de Lima Silva', admin: true, phone: '(11) 99999-9999')
  User.create(email: 'atendente@luzdomundo.com.br', password: 'abc123', name: 'Olivia Lobo', phone: '(11) 98765-4321')

  [
    'Manicure',
    'Pedicure',
    'Corte feminino',
    'Corte masculino',
    'Corte máquina',
    'Barba',
    'Barba desenhada',
    'Maquiagem',
    'Luzes',
    'Mechas',
    'Alisamento',
    'Progressiva',
    'Coloração',
    'Escova',
    'Sobrancelhas'
  ].each do |name|
    Service.create(name: name)
  end

  10.times do
    name = Faker::Name.name

    Customer.create(
      email: "#{name.split(' ').first}@gmail.com",
      name: name,
      phone: Faker::PhoneNumber.unique.cell_phone,
      details: ''
    )
  end

  5.times do
    services = Services.all
    name = Faker::Name.name

    Employee.create(
      name: Faker::Name.unique.name,
      phone: Faker::PhoneNumber.unique.cell_phone,
      email: "#{name.split(' ').first}@luzdomundo.com.br",
      document: Faker::IDNumber.unique.brazilian_citizen_number(formatted: true),
      address: Faker::Address.unique.street_address,
      birthdate: Faker::Date.birthday(min_age: 18, max_age: 50),
      services: services.sample([1,2,3].sample)
    )
  end
end
