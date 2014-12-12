class User < ActiveRecord::Base
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :email,           presence: true
  validates :email,           uniqueness: true, if: :email

  has_many :spaces
  has_one :access_token, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id

  delegate :token, to: :access_token
end
