# frozen_string_literal: true

class Order
  include ActiveGraphql::Api

  graphql_scope :for_wms_upload
end
