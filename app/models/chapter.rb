class Chapter < ActiveRecord::Base
  # name:string
  # address:string
  # city:string
  # state:string
  # zip:string
  # contact:string
  # email:string
  # invoice_sent:boolean

  scope :ordered, ->{ order(:name) }

  has_many :advisers, :dependent => :destroy, :inverse_of => :chapter
  has_many :teams, :dependent => :destroy, :inverse_of => :chapter
  has_many :students, :dependent => :destroy, :inverse_of => :chapter
  has_many :events, :through => :students

  # Validation
  validates :name, :presence => true, :uniqueness => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true, :format => /\A\d+\z/
  validates :contact, :presence => true
  validates :email, :presence => true, :email => true

  def can_register_for_event?(event, count)
    return true unless event.is_a? IndividualPerformanceEvent

    total_students = students.count

    if total_students <= 24 && count < 2
      true
    elsif total_students.between?(25, 49) && count < 3
      true
    elsif total_students >= 50 && count < 4
      true
    else
      false
    end
  end

  def to_param
    "#{id} #{name}".parameterize
  end

end
