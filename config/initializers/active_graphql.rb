# frozen_string_literal: true

require 'graphql/client'
require 'graphql/client/http'

module ActiveGraphql
  # Configure GraphQL endpoint using the basic HTTP network adapter.
  HTTP = GraphQL::Client::HTTP.new(ENV.fetch('SHOPIFY_GRAPHQL_ENDPOINT')) do
    def headers(context)
      { "X-Shopify-Access-Token" => ENV.fetch('SHOPIFY_ADMIN_TOKEN'), "Content-Type" => "application/json" }
    end
  end

  # Fetch latest schema on init, this will make a network request
  # Schema = GraphQL::Client.load_schema(HTTP)

  # However, it's smart to dump this to a JSON file and load from disk
  #
  # Run it from a script or rake task
  #   GraphQL::Client.dump_schema(SWAPI::HTTP, "path/to/schema.json")
  #
  Schema = GraphQL::Client.load_schema("shopify_schema.json")

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  Client.allow_dynamic_queries = true
end
