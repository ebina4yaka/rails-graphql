require 'validator/author_validator'

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  has_many :likes_relationships, -> { order('created_at DESC') }, dependent: :destroy
  has_many :liked_users, through: :likes_relationships, source: :user

  # validates
  validates :title, presence: true,
            length: { maximum: 50, allow_blank: true }

  validates :image_url, presence: true

  validates :content, presence: true,
            length: { maximum: 1000, allow_blank: true }

  validates :author, presence: true,
            author: true
end
