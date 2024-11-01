FactoryBot.define do
  factory :university_offer do
    association :course

    full_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    max_payments { Faker::Number.between(from: 12, to: 60) }
    enrollment_semester { '2025.1' }
  end
end
