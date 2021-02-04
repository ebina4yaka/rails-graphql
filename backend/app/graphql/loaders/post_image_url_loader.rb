module Loaders
  class PostImageUrlLoader < BaseLoader
    include Loaders::ImageUrl

    def perform(post_ids)
      Post.where(id: post_ids).includes(post_image_attachment: :blob).each do |post|
        fulfill(post.id, url_for(post.post_image))
      end
    end
  end
end
