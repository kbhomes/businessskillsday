class Event < ActiveRecord::Base
  # number:integer
  # name:string
  # nine_ten:boolean
  # type:string (internal, for STI)

  default_scope ->{ order(:number) }

  def self.types
    types = []
    types << 'WrittenEvent'
    types << 'IndividualPerformanceEvent'
    types << 'TeamPerformanceEvent'
  end

  def self.attributes_protected_by_default
    %w(id)
  end

  has_many :results, :class_name => 'Result', :inverse_of => :event

  # Validation
  validates :number, :presence => true, :numericality => true, :uniqueness => true
  validates :name, :presence => true, :uniqueness => true
  validates :type, :presence => true, :inclusion => { :in => Event.types }

  def students_for_chapter(chapter)
    if respond_to? :students and chapter.present?
      students.joins(:chapter).where(['chapters.id = ?', chapter])
    else
      []
    end
  end

  def participants
    []
  end

  def to_s
    s = name
    s += ' (9 - 10)' if nine_ten?
    s
  end

  def to_param
    "#{id} #{to_s}".parameterize
  end

end
