# frozen_string_literal: true

module GraphqlResource
  class NotFoundError < StandardError
    def initialize(message = 'Resource not found')
      super(message)
    end
  end
end
