FactoryGirl.define do

  factory :student do
    name  { Faker::Name.name }
    grade { rand(9..12) }
    chapter
  end

end
