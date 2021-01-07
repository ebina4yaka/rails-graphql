require 'validator/author_validator'

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  # validates
  validates :title, presence: true,
            length: { maximum: 50, allow_blank: true }

  validates :content, presence: true,
            length: { maximum: 1000, allow_blank: true }

  validates :author, presence: true,
            author: true
end
