class LikesRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
