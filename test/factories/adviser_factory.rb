FactoryGirl.define do

  factory :adviser do
    name { Faker::Name.name }
    association :chapter
  end

end