class User < ActiveRecord::Base
  module SignUpType
    EMAIL = 'email'
    FACEBOOK = 'facebook'
  end

  attr_accessor :sign_up_type

  has_secure_password validations: false

  validates :password,        presence: true,
                              length: { minimum: 6 }, on: :create, if: :signed_via_email?
  validates :password,        presence: true,
                              length: { minimum: 6 }, on: :update, if: :validate_password?
  validates_confirmation_of :password, if: :validate_password?

  validates :first_name,      presence: true
  validates :last_name,       presence: true

  validates :email,           uniqueness: true, on: :create, if: :signed_via_email?
  validates :email,           uniqueness: { case_sensitive: false }, on: :update, if: :email_changed?

  has_many :spaces
  has_one :access_token, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id

  delegate :token, to: :access_token

  def self.find_or_create_by_social_provider options
    user = self.where(provider_id: options[:provider_id],
                      provider: options[:provider]).first
    user || User.create(options)
  end

  private

  def signed_via_email?
    sign_up_type == SignUpType::EMAIL
  end

  def validate_password?
    password || password_confirmation
  end
end
