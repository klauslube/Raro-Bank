FactoryBot.define do
  factory :investment do
    name { Faker::Lorem.word }
    minimum_amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    income { Faker::Number.decimal(l_digits: 4) }
    premium { false }
    profit { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    expiration_date { Faker::Date.forward(days: 30) }
    association :approver, factory: :user

    trait :premium do
      premium { true }
    end
  end
end
