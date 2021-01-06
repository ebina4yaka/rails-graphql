module Mutations
  class CreateUser < BaseMutation
    field :user, Types::UserType, null: true

    argument :name, String, required: true
    argument :email, String, required: true
    argument :user_id, String, required: true
    argument :password, String, required: true

    def resolve(**args)
      user = User.new(args)
      if user.save
        { user: user }
      else
        build_errors(user)
        nil
      end
    end

    def build_errors(user)
      user.errors.each do |attr, message|
        full_message = user.errors.full_message(attr, message)
        context.add_error(GraphQL::ExecutionError.new(full_message, extensions: { code: 'USER_INPUT_ERROR', attribute: attr }))
      end
    end
  end
end
