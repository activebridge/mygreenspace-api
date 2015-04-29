class User < ActiveRecord::Base
  has_secure_password

  validates :password,        presence: true,
                              length: { minimum: 6 }, on: :create

  validates :email,           uniqueness: { allow_nil: true },       on: :create
  validates :email,           uniqueness: { case_sensitive: false }, on: :update

  validates :first_name,      presence: true
  validates :last_name,       presence: true

  has_many :spaces
  has_one :access_token, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id

  delegate :token, to: :access_token

  def self.find_or_create_by_social_provider options
    user = self.where(provider_id: options[:provider_id],
                      provider: options[:provider]).first
    user || User.create(options)
  end
end
