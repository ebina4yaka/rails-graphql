module Loaders
  class UserAvatarUrlLoader < BaseLoader
    include Loaders::ImageUrl

    def perform(user_ids)
      User.where(id: user_ids).includes(avatar_image_attachment: :blob).each do |user|
        fulfill(user.id, url_for(user.avatar_image))
      end
    end
  end
end
