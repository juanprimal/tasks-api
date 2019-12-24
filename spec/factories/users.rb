FactoryBot.define do
  factory :user do
    name { Faker::TvShows::SouthPark.character }
  end
end