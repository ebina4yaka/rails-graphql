module Loaders
  class UserFollowersCountLoader < GraphQL::Batch::Loader
    def perform(user_ids)
      FollowsRelationship.where(follow_id: user_ids).group(:follow_id).count.each do |follow_id, count|
        fulfill(follow_id, count)
      end
    end
  end
end
