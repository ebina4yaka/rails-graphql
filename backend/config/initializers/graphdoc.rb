GraphdocRuby.configure do |config|
  config.endpoint = "http://localhost:#{ENV.fetch("PORT") { 3000 }}/graphql"
end
