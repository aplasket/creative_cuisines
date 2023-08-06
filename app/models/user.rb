class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  has_secure_password
  has_secure_token :api_key, length: 32

  has_many :favorites
end
