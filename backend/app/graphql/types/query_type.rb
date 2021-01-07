module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    field :posts, [Types::PostType], null: false

    def users
      User.all.select(:id, :name, :screen_name, :activated, :admin, :created_at, :updated_at)
    end

    def posts
      Post.all
    end
  end
end
