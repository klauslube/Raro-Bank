FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_cpf }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, special_characters: true) }
  end
end
