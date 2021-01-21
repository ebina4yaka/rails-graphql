module Types
  class MutationType < Types::BaseObject
    field :unfollow_user, mutation: Mutations::UnfollowUser
    field :follow_user, mutation: Mutations::FollowUser
    field :create_post, mutation: Mutations::CreatePost
    field :create_user, mutation: Mutations::CreateUser
  end
end
