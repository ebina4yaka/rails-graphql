class ErrorsHelper
  def self.build_errors(context, type)
    type.errors.each do |attr, message|
      full_message = user.errors.full_message(attr, message)
      context.add_error(GraphQL::ExecutionError.new(full_message, extensions: { code: 'USER_INPUT_ERROR', attribute: attr }))
    end
  end

  def self.authorization_error(context)
    context.add_error(GraphQL::ExecutionError.new('認証エラー', extensions: { code: 'AUTHORIZATION_ERROR' }))
  end
end
