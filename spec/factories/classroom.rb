FactoryBot.define do
  factory :classroom do
    name { Faker::Educator.course_name }
    start_date { Faker::Date.backward(days: 30) }
    end_date { Faker::Date.forward(days: 30) }
  end
end
