module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    field :user, Types::UserType, null: true do
      argument :screen_name, String, required: true
    end
    field :posts, [Types::PostType], null: false
    field :post, Types::PostType, null: true do
      argument :id, Int, required: false
    end
    field :viewer, Types::ViewerType, null: true

    def users
      User.all.select(:id, :name, :screen_name, :activated, :admin, :created_at, :updated_at)
    end

    def user(screen_name:)
      User.find_by(screen_name: screen_name)
    end

    def posts
      Post.all
    end

    def post(id:)
      Post.find_by(id: id)
    end

    def viewer
      context[:current_user] || authorization_error
    end
  end
end
