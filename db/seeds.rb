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

# investment = Investment.new name: 'Selic', minimum_amount: 100, indicator_id: 1 ,premium: true, expiration_date: DateTime.tomorrow, approver_id: admin.id
# investment.skip_confirmation!
# investment.save!
