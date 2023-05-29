FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.decimal(l_digits: 7, r_digits: 2) }
    token { Faker::Alphanumeric.unique.alpha(number: 10) }
    status { :started }

    trait :status_started do
      status { :started }
    end

    trait :status_authenticated do
      status { :authenticated }
    end

    trait :status_pending do
      status { :pending }
    end

    trait :status_completed do
      status { :completed }
    end

    trait :status_canceled do
      status { :canceled }
    end
  end
end
