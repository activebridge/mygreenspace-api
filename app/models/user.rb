class User < ActiveRecord::Base
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :email,           uniqueness: true

  has_many :spaces
end
