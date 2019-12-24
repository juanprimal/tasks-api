FactoryBot.define do
  factory :user_task do
    description { Faker::Lorem.sentence }
    state { false }
    user_id { nil }
  end
end