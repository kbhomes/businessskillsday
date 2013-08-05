class Registration < ActiveRecord::Base
  # chapter:string
  # address:string
  # city:string
  # state:string
  # zip:string
  # contact:string
  # email:string
  # Validation

  validates :chapter, :presence => true, :uniqueness => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true, :format => /\A\d+\z/
  validates :contact, :presence => true
  validates :email, :presence => true, :email => true, :uniqueness => true

  validate :validate_chapter_uniqueness
  validate :validate_email_uniqueness

  def validate_chapter_uniqueness
    errors.add(:chapter, 'is already in use by an existing chapter') unless Chapter.where(:name => self.chapter).count == 0
  end

  def validate_email_uniqueness
    errors.add(:email, 'is already in use by an existing account') unless Account.where(:email => self.email).count == 0
  end

end
