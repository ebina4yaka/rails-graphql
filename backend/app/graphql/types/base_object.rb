module Types
  module ImageUrl
    extend ActiveSupport::Concern
    include Rails.application.routes.url_helpers

    included do
      Rails.application.routes.default_url_options[:host] = 'localhost:8080'
    end
  end
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    def authorization_error
      ErrorsHelper.authorization_error(context)
    end
  end
end
