FactoryBot.define do
  factory :account do
    balance { Faker::Number.decimal(l_digits: 7, r_digits: 2) }
    association :user, factory: :user
  end
end
