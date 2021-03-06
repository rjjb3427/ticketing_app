class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :tickets

  # Enums
  enum role: [:user, :agent, :admin]

  # Callbacks
  after_initialize :set_defaults, if: :new_record?
  before_create :generate_authentication_token!

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :auth_token

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  private
  def set_defaults
    self.role ||= :user
  end
end
