FactoryBot.define do
  factory :note do
    note { Faker::Lorem.sentence }
    created_by { Faker::Number.number(10) }
  end
end
