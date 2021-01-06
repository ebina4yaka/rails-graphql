class User < ApplicationRecord
  # bcrypt
  has_secure_password
  # validates
  validates :name, presence: true,
            length: { maximum: 30, allow_blank: true }

  validates :user_id, presence: true,
            uniqueness: true

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
            length: { minimum: 8 },
            format: {
              with: VALID_PASSWORD_REGEX,
              message: :invalid_password
            },
            allow_blank: true
end
