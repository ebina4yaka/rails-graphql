module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    def authorization_error
      ErrorsHelper.authorization_error(context)
    end
  end
end
