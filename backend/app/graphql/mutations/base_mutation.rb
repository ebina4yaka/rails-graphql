require_relative '../helper/errors_helper'

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def authorization_error
      ErrorsHelper.add_error_to_context(context, '認証エラー', 'AUTHORIZATION_ERROR')
    end

    def image_not_found_error
      ErrorsHelper.add_error_to_context(context, '画像がありません', 'IMAGE_NOT_FOUND_ERROR')
    end

    def build_errors(type)
      ErrorsHelper.build_errors(context, type)
    end
  end
end
