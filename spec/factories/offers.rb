FactoryBot.define do
  factory :offer do
    association :university_offer

    discount_percentage { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    enabled { true }

    trait :disabled do
      enabled { false }
    end
  end
end
