# Create super user admin
admin = User.new name: 'User Admin', cpf: '00011100011', email: 'admin@rarobank.com', password: 'r@robank123', role: 3
admin.skip_confirmation!
admin.save!

# Create free user
free = User.new name: 'User Free', cpf: '00022200011', email: 'free@rarobank.com', password: 'r@robank123', role: 1
free.skip_confirmation!
free.save!

# Create premium user
premium = User.new name: 'User Premium', cpf: '00033300011', email: 'premium@rarobank.com', password: 'r@robank123', role: 2
premium.skip_confirmation!
premium.save!

# Create only free users
100.times do
  name = Faker::Name.name
  cpf = Faker::IDNumber.brazilian_citizen_number
  email = Faker::Internet.email
  password = 'r@robank123'

  user = User.new(name:, cpf:, email:, password:)
  user.skip_confirmation!
  user.save!
end

# Create classrooms
20.times do
  name = Faker::Educator.course_name
  start_date = Faker::Date.between(from: 1.year.ago, to: Time.zone.today)
  end_date = Faker::Date.between(from: start_date, to: start_date + 1.year)

  Classroom.create!(name:, start_date:, end_date:)
end
