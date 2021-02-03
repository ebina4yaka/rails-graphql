module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :image_url, String, null: false
    field :content, String, null: false
    field :author, UserType, null: false
    field :liked_users, UserType::connection_type, null: false
    field :liked_users_count, Int, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def author
      Loaders::RecordLoader.for(User).load(object.author_id)
    end

    def liked_users
      Loaders::AssociationLoader.for(Post, :liked_users).load(object)
    end

    def liked_users_count
      Loaders::PostLikedUsersCountLoader.for.load(object.id)
    end
  end
end
