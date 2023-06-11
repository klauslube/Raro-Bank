FactoryBot.define do
  factory :user_investment do
    initial_amount { Faker::Number.decimal(l_digits: 7, r_digits: 2) }
    profit { Faker::Number.decimal(l_digits: 7, r_digits: 2) }

    user
    investment
  end
end
