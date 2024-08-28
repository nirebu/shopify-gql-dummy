# frozen_string_literal: true

module Customer::Fragments
  Default = ShopifyGqlApi::Client.parse <<~GRAPHQL.squish
    fragment on Customer {
      id
      email
      firstName
      lastName
      phone
      createdAt
      updatedAt
    }
  GRAPHQL
end
