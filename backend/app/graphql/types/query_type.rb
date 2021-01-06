module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false

    def users
      User.all.select(:id, :name, :email, :user_id, :activated, :admin, :created_at, :updated_at)
    end
  end
end
