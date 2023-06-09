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

investment = Investment.new name: 'CDI', minimum_amount: 200, start_date: Date.current, expiration_date: Date
             .tomorrow, premium: true, approver_id: admin.id, indicator_id: 1
investment.save!

investment2 = Investment.new name: 'SELIC', minimum_amount: 100, start_date: Date.current, expiration_date: Date
              .tomorrow, premium: true, approver_id: admin.id, indicator_id: 2
investment2.save!

investment3 = Investment.new name: 'IPCA', minimum_amount: 300, start_date: Date.current, expiration_date: Date
              .tomorrow, premium: false, approver_id: admin.id, indicator_id: 3
investment3.save!
