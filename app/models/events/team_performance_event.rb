class TeamPerformanceEvent < PerformanceEvent

  has_many :teams, :foreign_key => 'event_id'

  before_destroy :handle_destroy

  def participants
    teams
  end

  def handle_destroy
    teams.each { |t| t.destroy }
  end

end
