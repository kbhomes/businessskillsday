# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    sequence(:chapter) { |n| "Chapter #{n}" }
    sequence(:email) { |n| "chapter#{n}@example.com" }
    contact { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip[0..4] }
  end
end
