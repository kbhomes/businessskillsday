FactoryGirl.define do

  factory :chapter do
    sequence(:name) { |n| Faker::Company.name + " #{n} High School" }
    address         { Faker::Address.street_address }
    city            { Faker::Address.city }
    state           { Faker::Address.state_abbr }
    zip             { Faker::Address.zip[0..4] }
    contact         { Faker::Name.name }
    email           { (contact || Faker::Name.name).downcase.gsub(' ', '') + '@example.com' }
    invoice_sent    false
  end

end