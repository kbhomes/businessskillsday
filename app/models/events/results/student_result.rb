class StudentResult < Result
  belongs_to :participant, :class_name => 'Student'
end