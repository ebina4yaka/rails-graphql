module Loaders
  module ImageUrl
    extend ActiveSupport::Concern
    include Rails.application.routes.url_helpers

    included do
      Rails.application.routes.default_url_options[:host] = 'localhost:8080'
    end
  end

  class BaseLoader < GraphQL::Batch::Loader
  end
end
