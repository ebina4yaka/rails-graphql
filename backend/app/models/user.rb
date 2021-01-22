require 'validator/email_validator'

class User < ApplicationRecord
  has_many :posts, -> { order('created_at DESC') }, foreign_key: :author_id, dependent: :destroy

  has_many :follows_relationships
  has_many :followings, through: :follows_relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'FollowsRelationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_many :likes_relationships, dependent: :destroy
  has_many :like_posts, through: :likes_relationships, source: :post

  def follow(other_user)
    unless self == other_user
      self.follows_relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.follows_relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  before_validation :downcase_email

  # bcrypt
  has_secure_password

  # validates
  validates :name, presence: true,
            length: { maximum: 30, allow_blank: true }

  validates :email, presence: true,
            email: { allow_blank: true }

  VALID_SCREEN_NAME_REGEX = /\A[\w\-]+\z/
  validates :screen_name, presence: true,
            uniqueness: true,
            length: { minimum: 4, allow_blank: true },
            format: {
              with: VALID_SCREEN_NAME_REGEX,
              message: :invalid_screen_name,
              allow_blank: true
            }

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
