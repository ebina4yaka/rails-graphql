require_relative '../helper/errors_helper'

module Mutations
  class CreatePost < BaseMutation
    field :post, Types::PostType, null: true

    argument :title, String, required: true
    argument :content, String, required: true
    argument :image_base64, String, required: true

    def resolve(**args)
      user = context[:current_user]
      if user.nil?
        authorization_error
        return nil
      end
      post = user.posts.new(title: args[:title], content: args[:content])
      if post.save
        post.parse_base64(args[:image_base64], post.post_image)
        { post: post }
      else
        build_errors(post)
        nil
      end
    end
  end
end
