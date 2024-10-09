# frozen_string_literal: true

class Order
  module Fragments
    Default = ActiveGraphql::Client.parse <<~GRAPHQL
      fragment on Order {
        id
        name
      }
    GRAPHQL
  end
end
