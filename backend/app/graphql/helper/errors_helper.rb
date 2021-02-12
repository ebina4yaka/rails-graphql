class ErrorsHelper
  def self.build_errors(context, type)
    type.errors.each do |attr, message|
      full_message = type.errors.full_message(attr, message)
      context.add_error(GraphQL::ExecutionError.new(full_message, extensions: { code: 'USER_INPUT_ERROR', attribute: attr }))
    end
  end

  def self.add_error_to_context(context, message, code)
    context.add_error(GraphQL::ExecutionError.new(message, extensions: { code: code }))
  end
end
