FactoryGirl.define do
  factory :result do
    score { rand 100 }
    association(:event, :factory => :written_event)
    association(:participant, :factory => :student)
    type 'StudentResult'
  end

  factory :student_result, :parent => :result, :class => 'StudentResult' do
    association(:event, :factory => :written_event)
    association(:participant, :factory => :student)
    type 'StudentResult'
  end

  factory :team_result, :parent => :result, :class => 'StudentResult' do
    association(:event, :factory => :team_performance_event)
    association(:participant, :factory => :team)
    type 'TeamResult'
  end

end
