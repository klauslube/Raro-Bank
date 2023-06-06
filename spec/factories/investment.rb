FactoryBot.define do
  factory :investment do
    name { Faker::Lorem.word }
    minimum_amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    premium { false }
    expiration_date { Faker::Date.forward(days: 30) }
    approver_id { FactoryBot.create(:user, role: :admin).id }
    # indicator_id { FactoryBot.create(:indicator, name: 'SELIC').id }

    association :approver, factory: :user
    association :indicator, factory: :indicator, id: 1

    trait :premium do
      premium { true }
    end
  end
end
