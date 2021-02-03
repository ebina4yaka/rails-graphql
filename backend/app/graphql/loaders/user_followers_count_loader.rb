module Loaders
  class UserFollowersCountLoader < GraphQL::Batch::Loader
    def perform(user_ids)
      User.joins('left outer join follows_relationships f on users.id = f.follow_id')
          .where(id: user_ids).group(:id)
          .count(:follow_id).each do |follow_id, count|
        fulfill(follow_id, count)
      end
    end
  end
end
