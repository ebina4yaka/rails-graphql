module Mutations
  class LikePost < BaseMutation
    field :isLiking, Boolean, null: true

    argument :post_id, Int, required: true

    def resolve(**args)
      user = context[:current_user]
      if user.nil?
        authorization_error
        return nil
      end
      like_post = Post.find_by(id: args[:post_id])
      if like_post.nil?
        return nil
      end
      like_posts = user.like(like_post)
      if like_posts.nil?
        return nil
      end
      if like_posts.save
        { isLiking: true }
      else
        build_errors(like_posts)
        nil
      end
    end
  end
end
