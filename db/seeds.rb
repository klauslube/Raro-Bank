# frozen_string_literal: true

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

# Create classroom
20.times do
  name = Faker::Educator.course_name
  start_date = Faker::Date.between(from: 1.year.ago, to: Date.today)
  end_date = Faker::Date.between(from: start_date, to: start_date + 1.year)

  Classroom.create!(name:, start_date:, end_date:)
end
