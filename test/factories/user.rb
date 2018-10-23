FactoryBot.define do
  factory :user do
    uid { "1"}
    username { Faker::Name.first_name }
    email { "lbird@ada.com" }
  end
end
