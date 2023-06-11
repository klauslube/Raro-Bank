FactoryBot.define do
  factory :token do
    code { Faker::Number.unique.number(digits: 6) }
    active { true }
    transfer factory: %i[transaction]
  end
end
