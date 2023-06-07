FactoryBot.define do
  factory :indicator do
    name { Faker::Educator.course_name }
    rate { rand(0.00006..1).round(4) }
    rate_date { DateTime.now }
  end
end
