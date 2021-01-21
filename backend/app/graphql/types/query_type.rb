module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, Types::UserType::connection_type, null: false
    field :user, Types::UserType, null: true do
      argument :screen_name, String, required: true, description: 'ユーザー名'
    end
    field :posts, Types::PostType::connection_type, null: false do
      argument :author_id, Int, required: false, description: '投稿者ID'
      argument :order_by, PostsOrderInput, required: false, description: 'ソート'
    end
    field :post, Types::PostType, null: true do
      argument :id, Int, required: false, description: 'ID'
    end
    field :viewer, Types::ViewerType, null: true

    def users
      User.all
    end

    def user(screen_name:)
      User.find_by(screen_name: screen_name)
    end

    def posts(author_id: nil, order_by: nil)
      if author_id != nil && order_by != nil
        field = order_by[:field].underscore
        direction = order_by[:direction]
        return Post.where(author_id: author_id).order("#{field} #{direction}")
      end
      if author_id != nil
        return Post.where(author_id: author_id)
      end
      if order_by != nil
        field = order_by[:field].underscore
        direction = order_by[:direction]
        return Post.order("#{field} #{direction}")
      end
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
