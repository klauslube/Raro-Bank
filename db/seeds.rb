# Create super user admin
admin = User.new name: 'User Admin', cpf: '00011100011', email: 'admin@rarobank.com', password: 'r@robank123', role: 3
admin.skip_confirmation!
admin.save!

puts 'Admin created!'

# Create free user
free = User.new name: 'User Free', cpf: '00022200011', email: 'free@rarobank.com', password: 'r@robank123', role: 1
free.skip_confirmation!
free.save!

puts 'Free created!'

# Create premium user
premium = User.new name: 'User Premium', cpf: '00033300011', email: 'premium@rarobank.com', password: 'r@robank123', role: 2
premium.skip_confirmation!
premium.save!

puts 'Premium created!'

# Create only free users
100.times do
  name = Faker::Name.name
  cpf = Faker::IDNumber.brazilian_citizen_number
  email = Faker::Internet.email
  password = 'r@robank123'

  user = User.new(name:, cpf:, email:, password:)
  user.skip_confirmation!
  user.save!

  puts "User #{user.name} created!"
end

users = User.all_except_admins
accounts = Account.not_admin

# Set amount of raracoins for each account
accounts.each do |account|
  account.update(balance: 1000)

  puts "Account #{account.id} updated!"
end

classe_names = ['JavaScript', 'Python', 'Java', 'Ruby on Rails', 'C++', 'PHP', 'Swift', 'Golang', 'Ruby', 'TypeScript', 'HTML/CSS', 'React', 'Angular', 'Vue.js', 'Node.js']

# Create classrooms with users free
classe_names.each do |class_name|
  name = class_name
  start_date = Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  end_date = Faker::Date.between(from: start_date, to: start_date + 3.months)

  classroom = Classroom.new(name:, start_date:, end_date:)

  10.times do
    user = users.sample
    classroom.users << user
  end

  classroom.save!

  puts "Classroom #{classroom.name} created!"
end

# Create transactions

30.times do
  amount = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  sender = accounts.sample
  accoutns_whithout_sender = accounts.where.not(id: sender.id)
  receiver = accoutns_whithout_sender.sample

  transaction = Transaction.new(amount:, sender:, receiver:)
  transaction.save_without_token!

  puts "Transaction between #{sender.user.name} and #{sender.user.name} created!"
end

# Create deposits

20.times do
  amount = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  sender = admin.account
  sender.balance += amount
  receiver = accounts.sample

  deposit = Transaction.new(sender:, receiver:, amount:)
  deposit.save_without_token!

  puts "Deposit #{deposit.id} created!"
end

IndicatorService.import_indicators
indicators = Indicator.all
available_names = Indicator.pluck(:name)
available_variations = []

(110..250).step(10).each do |percentage|
  available_variations << "#{percentage}%"
end

# Create investments
20.times do
  name = "#{available_names.sample} #{available_variations.sample}".upcase
  minimum_amount = Faker::Number.decimal(l_digits: 2, r_digits: 2).to_f * 100
  premium = Faker::Boolean.boolean
  expiration_date = Faker::Date.between(from: Time.zone.today, to: 1.year.from_now)
  approver = admin
  indicator = indicators.sample

  investment = Investment.new(name:, minimum_amount:, premium:, expiration_date:, approver:, indicator:)

  5.times do
    user = users.sample
    user.investments << investment
  end

  investment.save!

  puts "Investment #{investment.name} created!"
end

puts 'Seeds created!'
