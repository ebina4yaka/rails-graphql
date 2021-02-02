module Loaders
  class PostLikedUsersCountLoader < GraphQL::Batch::Loader
    def perform(post_ids)
      Post.includes(:likes_relationships).where(likes_relationships: post_ids).group(:id)
          .count(:likes_relationships).each do |post_id, count|
        fulfill(post_id, count)
      end
    end
  end
end
