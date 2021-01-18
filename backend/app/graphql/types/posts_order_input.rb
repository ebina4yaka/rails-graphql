module Types
  class PostsOrderInput < Types::BaseInputObject
    argument :direction, Types::OrderDirection, required: false
    argument :field, Types::PostsOrderInputField, required: false
  end
end
