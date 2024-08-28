# frozen_string_literal: true

module GraphqlResource
  module SharedFragments
    PageInfo = ShopifyGqlApi::Client.parse <<~GRAPHQL.squish
      fragment on PageInfo {
        hasNextPage
        endCursor
      }
    GRAPHQL

    UserErrors = ShopifyGqlApi::Client.parse <<~GRAPHQL.squish
      fragment on UserError {
        field
        message
      }
    GRAPHQL
  end
end
