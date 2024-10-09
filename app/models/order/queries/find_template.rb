# frozen_string_literal: true

class Order
  module Queries
    FindTemplate = <<~GRAPHQL
      query($id: ID!) {
        order(id: $id) {
          %<fragment>s
        }
      }
    GRAPHQL
  end
end
