FactoryBot.define do
  factory :user_investment do
    association :user, factory: :user
    association :investment, factory: :investment
    initial_amount { Faker::Number.decimal(l_digits: 7, r_digits: 2) }
  end
end
