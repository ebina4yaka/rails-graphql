require_relative '../helper/errors_helper'

module Mutations
  class CreatePost < BaseMutation
    field :post, Types::PostType, null: true

    argument :title, String, required: true
    argument :content, String, required: true

    def resolve(**args)
      user = context[:current_user]
      if user.nil?
        authorization_error
        return nil
      end
      post = user.posts.new(args)
      if post.save
        { post: post }
      else
        build_errors(post)
        nil
      end
    end
  end
end
