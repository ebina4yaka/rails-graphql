module Mutations
  class UnfollowUser < BaseMutation
    field :isFollowing, Boolean, null: true

    argument :follow_id, Int, required: true

    def resolve(**args)
      user = context[:current_user]
      if user.nil?
        authorization_error
        return nil
      end
      follow_user = User.find_by(id: args[:follow_id])
      if follow_user.nil?
        return nil
      end
      following = user.unfollow(follow_user)
      if following.nil?
        return nil
      end
      if following.destroy
        { isFollowing: user.following?(follow_user) }
      else
        build_errors(following)
        nil
      end
    end
  end
end
