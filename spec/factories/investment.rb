FactoryBot.define do
  factory :investment do
    name { Faker::Lorem.word }
    minimum_amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    premium { false }
    start_date { Date.current }
    expiration_date { Faker::Date.forward(days: 30) }
    approver_id { FactoryBot.create(:user, role: :admin).id }
    indicator_id { FactoryBot.create(:indicator).id }

    approver factory: %i[user]
    indicator factory: %i[indicator], id: 1

    trait :premium do
      premium { true }
    end
  end
end
