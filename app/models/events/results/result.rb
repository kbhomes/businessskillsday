class Result < ActiveRecord::Base
  # score:integer
  # event_id:integer
  # participant_id:integer
  # type:string (internal, for STI)

  default_scope ->{ order('score DESC') }
  scope :top_five, ->{ limit(5) }

  def self.types
    types = []
    types << StudentResult
    types << TeamResult
    types.map { |type| type.name }
  end

  def self.attributes_protected_by_default
    %w(id)
  end

  belongs_to :event, :inverse_of => :results
  belongs_to :participant, :class_name => 'Student'

  # Validations
  validates :score, :presence => true, :numericality => true
  validates :event, :presence => true
  validates :participant, :presence => true
  validate :unique_participant_on_event

  def rank
    rank = event.results.index(self) + 1
    rank unless rank > 5
  end

  def to_param
    if new_record?
      ""
    else
      "#{id} #{rank.ordinalize if rank.present?} #{participant.to_s}".parameterize
    end
  end

  private

    def unique_participant_on_event
      if event.present? && participant.present?
        errors.add(:participant, 'was already awarded a different rank') unless event.results.where{ |q| (q.participant_id == participant.id) & (q.id != id)}.count == 0
      end
    end
end
