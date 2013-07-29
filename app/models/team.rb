class Team < ActiveRecord::Base

  scope :ordered, ->{ joins(:event).joins(:chapter).reorder('events.name', 'chapters.name') }

  before_destroy :handle_destroy

  belongs_to :chapter, :inverse_of => :teams
  belongs_to :event, :class_name => 'TeamPerformanceEvent', :foreign_key => 'event_id'
  has_many :students,
           :inverse_of => :team,
           :extend => TeamStudentsAssociationExtension
  has_one :result, :class_name => 'TeamResult', :foreign_key => 'participant_id'

  # Validations
  validates :chapter, :presence => true
  validates :event, :presence => true

  validate :validate_chapter_and_event
  validate :validate_students

  def validate_chapter_and_event
    if event.present? && chapter.present? && event.teams.where{ |q| (q.chapter_id == chapter.id) & (q.id != id) }.count > 0 # event.teams.any? { |team| team.chapter == chapter unless team.id == id }
      errors.add(:event, 'cannot participate in an event that has a different team from the same chapter')
    end
  end

  def validate_students
    return if students.count <= 4
    errors.add(:students, 'cannot have more than 4 students')
  end

  # Called before_destory
  def handle_destroy
    if event.present?
      students.each do |student|
        # Remove the student's relationship to the team.
        student.team = nil
        student.save!

        # Remove the team event from the student.
        student.events.delete(event)
      end
    end
  end

  def can_register_student?(student)
    return true if students.include?(student)

    return false unless students.count < 4
    return false unless chapter == student.chapter

    true
  end

  def event_name
    event.name if event.present?
  end

  def to_s
    event_name
  end

  def to_param
    "#{id} #{to_s}".parameterize
  end

end
