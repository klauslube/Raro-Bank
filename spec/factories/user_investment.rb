FactoryBot.define do
  factory :user_investment do
    user factory: %i[user]
    investment factory: %i[investment]
    initial_amount { Faker::Number.decimal(l_digits: 7, r_digits: 2) }
    profit { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
