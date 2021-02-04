module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :screen_name, String, null: false
    field :posts, Types::PostType::connection_type, null: false
    field :followings, Types::UserType::connection_type, null: false
    field :followers, Types::UserType::connection_type, null: false
    field :like_posts, Types::PostType::connection_type, null: false
    field :activated, Boolean, null: false
    field :admin, Boolean, null: false
    field :biography, String, null: false
    field :avatar_url, String, null: true
    field :followers_count, Int, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def avatar_url
      url_for(object.avatar_image) if object.avatar_image.attached?
    end

    def posts
      Loaders::AssociationLoader.for(User, :posts).load(object)
    end

    def followings
      Loaders::AssociationLoader.for(User, :followings).load(object)
    end

    def followers
      Loaders::AssociationLoader.for(User, :followers).load(object)
    end

    def like_posts
      Loaders::AssociationLoader.for(User, :like_posts).load(object)
    end

    def followers_count
      Loaders::UserFollowersCountLoader.for.load(object.id)
    end
  end
end
