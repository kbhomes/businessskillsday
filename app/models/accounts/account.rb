class Account < ActiveRecord::Base
  # email:string
  # password_digest:string
  # remember_token:string
  # type:string (internal, for STI)

  def self.types
    types = []
    types << 'AdminAccount'
    types << 'StaffAccount'
    types << 'ChapterAccount'
  end

  # Associate the account with a chapter.
  #   Note, this is only really useful with the ChapterAccount class,
  #   but we're putting this here so that forms can access the chapter on the
  #   base Account model. Putting the related chapter validation in the
  #   ChapterAccount class basically restricts its usage to that class, so we're good.
  belongs_to :chapter

  # Create a new remember_token every time this account changes.
  before_save :update_remember_token

  # Password and authentication
  has_secure_password
  validates :password_digest, :presence => true, :on => :create

  # Has to go here so that we both unprotect 'type' and protect 'password_digest'
  # (has_secure_password overwrites this class method)
  def self.attributes_protected_by_default
    %w(id password_digest)
  end

  # Validations
  validates :email, :presence => true, :uniqueness => true, :email => true
  validates :type, :presence => true, :inclusion => { :in => Account.types }

  validates :password,
            :presence => true,
            :length => { :minimum => 6 },
            :if => ->(a){ a.password.present? }

  def display_name
    email
  end

  def to_param
    "#{id} #{display_name}".parameterize
  end

  def self.create_and_setup(params)
    type = params.delete(:type)
    password = SecureRandom.hex(10)
    params[:password] = params[:password_confirmation] = password

    # Make sure the type parameter is valid.
    raise 'Account type is not valid' unless Account.types.include?(type)

    account = (type.constantize).new(params)

    if account.save
      AccountMailer.new_account(account, password).deliver
    end

    account
  end

  private

    def update_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end