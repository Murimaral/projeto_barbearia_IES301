if User.count.zero?
  User.create(email: 'user@email.com', password: 'abc123', name: 'Olivia Lobo', phone: '(11) 987654321')
  User.create(email: 'admin@barbershop.com', password: 'abc123', name: 'ConnectPlus', admin: true, phone: '(11) 912345678')
  Customer.create(email: 'leticia@cta.com.br', name: 'Mayumi', phone: '(11) 123456789', details: 'oi descriçao')
  Customer.create(email: 'lucas@cta.com.br', name: 'Lucas', phone: '(11) 931233213', details: 'primo da Adelaide')

  5.times do
    Service.create(name: Faker::Job.title)
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

  Employee.first.update(services: [Service.first])
end
