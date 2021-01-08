module Mutations
  class CreateUser < BaseMutation
    field :user, Types::ViewerType, null: true

    argument :name, String, required: true
    argument :email, String, required: true
    argument :screen_name, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    def resolve(**args)
      user = User.new(args)
      if user.save
        { user: user }
      else
        build_errors(user)
        nil
      end
    end
  end
end
