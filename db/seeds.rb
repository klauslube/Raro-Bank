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

investment = Investment.new name: 'Selic', minimum_amount: 100, income: 0.1, premium: true, profit: 110, expiration_date: DateTime.tomorrow, approver_id: '7f49e628-01d5-4c94-b196-9e322ed03479'
investment.skip_confirmation!
investment.save!
