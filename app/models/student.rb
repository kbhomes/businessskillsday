class Student < ActiveRecord::Base
  # name:string
  # grade:integer

  default_scope order(:name)
  scope :ordered, joins(:chapter).reorder('chapters.name', 'students.name')

  before_save :handle_team
  before_destroy :handle_destroy

  belongs_to :chapter, :inverse_of => :students
  belongs_to :team, :inverse_of => :students
  has_and_belongs_to_many :events, :extend => StudentEventsAssociationExtension
  has_many :results, :class_name => 'StudentResult', :foreign_key => 'participant_id'

  # Validations
  validates :name, :presence => true
  validates :grade, :presence => true, :inclusion => 9..12
  validates :chapter, :presence => true

  validate :validate_grade
  validate :validate_events

  def validate_grade
    events.each do |ev|
      if ev.nine_ten? && (11..12).include?(grade)
        errors.add(:grade, 'does not match with registered grade 9/10 events')
        return false
      end
    end
  end

  def validate_events
    return if events.count <= 3
    errors.add(:events, "Can't participate in more than 3 events (including team events)")
  end

  def handle_team
    return true unless self.team_id_changed?

    if team.blank?
      # Remove any team events from the student.
      self.events.delete(self.events.where(:type => 'TeamPerformanceEvent'))
    else
      if !self.events.include?(team.event) && !(self.events << team.event)
        self.team_id = nil
        return false
      end
    end
  end

  def handle_destroy
    # Remove this student from all of its events.
    events.each { |ev| ev.respond_to?(:students) && ev.students.delete(self) }

    # Remove this student from its team.
    team.students.delete self if team.present?
  end

  def can_register_for_event?(event)
    return true if events.include?(event)

    return false unless events.count < 3
    return false if event.present? && event.nine_ten && (11..12).include?(grade)
    return false if event.present? && event.is_a?(WrittenEvent) && !(events.where{type == 'WrittenEvent' }.count < 3)
    return false if event.present? && event.is_a?(PerformanceEvent) && events.where{type == 'PerformanceEvent' }.exists?

    true
  end

  def can_register_for_team?(team)
    return true if self.team == team

    return false unless events.count < 3
    return false unless events.select { |ev| ev.is_a? PerformanceEvent }.count == 0

    true
  end

  def to_s
    name
  end

  def to_param
    "#{id} #{name}".parameterize
  end

end
