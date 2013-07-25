FactoryGirl.define do

  factory :event do
    sequence(:number)
    sequence(:name)   { |n| Faker::Company.name + " #{n}" }
    nine_ten          false
    type              'Event'
  end

  factory :written_event, :parent => :event, :class => 'WrittenEvent' do
    type 'WrittenEvent'
  end

  factory :performance_event, :parent => :event, :class => 'PerformanceEvent' do
    type 'PerformanceEvent'
  end

  factory :individual_performance_event, :parent => :event, :class => 'IndividualPerformanceEvent' do
    type 'IndividualPerformanceEvent'
  end

  factory :team_performance_event, :parent => :event, :class => 'TeamPerformanceEvent' do
    type 'TeamPerformanceEvent'
  end

end