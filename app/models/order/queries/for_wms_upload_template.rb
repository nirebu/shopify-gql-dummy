# frozen_string_literal: true

class Order
  module Queries
    ForWmsUploadTemplate = <<~GRAPHQL
      query for_wms_upload($first: Int = 50, $cursor: String) {
        for_wms_upload: orders(first: $first, after: $cursor) {
          edges {
            node {
              %<fragment>s
            }
          }
          pageInfo {
            endCursor
            hasNextPage
          }
        }
      }
    GRAPHQL
  end
end
