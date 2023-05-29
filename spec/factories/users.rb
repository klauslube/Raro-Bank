FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_cpf }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, special_characters: true) }
    role { :premium }

    trait :admin do
      role { :admin }
    end

    trait :admin do
      role { :free }
    end
  end
end
