# frozen_string_literal: true

class Customer
  module Queries
    module Templates
      Find = <<~GRAPHQL.squish
        query($id: ID!) {
          customer(id: $id) {
            %<fragment>s
          }
        }
      GRAPHQL

      Where = <<~GRAPHQL.squish
        query($query: String!, $objects_per_query: Int = 50, $cursor: String) {
          customers(query: $query, first: $objects_per_query, after: $cursor) {
            edges {
              node {
                %<fragment>s
              }
            }
            pageInfo {
              ...GraphqlResource::SharedFragments::PageInfo
            }
          }
        }
      GRAPHQL
    end
  end
end
