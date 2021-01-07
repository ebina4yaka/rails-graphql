Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  post "/graphql", to: "graphql#execute"
  mount GraphdocRuby::Application, at: 'graphdoc'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end
