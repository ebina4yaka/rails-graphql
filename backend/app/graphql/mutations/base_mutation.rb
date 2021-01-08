require_relative '../helper/errors_helper'

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def authorization_error
      ErrorsHelper.authorization_error(context)
    end

    def build_errors(type)
      ErrorsHelper.build_errors(context, type)
    end
  end
end
