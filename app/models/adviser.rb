class Adviser < ActiveRecord::Base
  # name:string

  scope :ordered, joins(:chapter).reorder('chapters.name', 'advisers.name')

  belongs_to :chapter, :inverse_of => :advisers

  # Validations
  validates :name, :presence => true
  validates :chapter, :presence => true

  def to_param
    "#{id} #{name}".parameterize
  end

end
