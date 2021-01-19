module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :screen_name, String, null: false
    field :posts, Types::PostType::connection_type, null: false
    field :activated, Boolean, null: false
    field :admin, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def posts
      Loaders::AssociationLoader.for(User, :posts).load(object)
    end
  end
end
