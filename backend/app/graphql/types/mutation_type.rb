module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::CreatePost
    field :create_user, mutation: Mutations::CreateUser
  end
end
