class TeamResult < Result
  belongs_to :participant, :class_name => 'Team'
end