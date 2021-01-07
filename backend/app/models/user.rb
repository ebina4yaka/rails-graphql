require "validator/email_validator"

class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy

  before_validation :downcase_email

  # bcrypt
  has_secure_password

  # validates
  validates :name, presence: true,
            length: { maximum: 30, allow_blank: true }

  validates :email, presence: true,
            email: { allow_blank: true }

  validates :screen_name, presence: true,
            uniqueness: true

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
            length: { minimum: 8 },
            format: {
              with: VALID_PASSWORD_REGEX,
              message: :invalid_password
            },
            allow_blank: true

  # methods
  class << self
    def find_activated(email)
      find_by(email: email, activated: true)
    end
  end

  def email_activated?
    users = User.where.not(id: id)
    users.find_activated(email).present?
  end

  private

  def downcase_email
    self.email.downcase! if email
  end
end
