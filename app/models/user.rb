class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
end
