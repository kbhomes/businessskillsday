FactoryGirl.define do

  factory :team do
    association :chapter
    association :event, :factory => :team_performance_event
  end

end