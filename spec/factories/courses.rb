FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    level { 'Bacharelado' }
    kind { 'Presencial' }
    shift { 'Integral' }
  end
end
