class IndividualPerformanceEvent < PerformanceEvent

  has_and_belongs_to_many :students,
                          :join_table => 'events_students',
                          :foreign_key => 'event_id'

  def participants
    students
  end

end
