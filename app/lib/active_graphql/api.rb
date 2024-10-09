# frozen_string_literal: true

module ActiveGraphql::Api
  extend ActiveSupport::Concern

  included do
    def initialize(attrs = {})
      attrs.each do |key, val|
        self.class.attr_accessor key
        self.send("#{key}=", val)
      end
    end
  end

  class_methods do
    def find(id, fragment: "...#{name}::Fragments::Default")
      query_name = name.underscore

      result = ActiveGraphql::Client.query(
        ActiveGraphql::Client.parse(format(name.constantize::Queries::FindTemplate, fragment: fragment)),
        variables: { id: id }
      )

      raise result.errors.to_s if result.errors.any?
      raise NotFoundError unless result.data.public_send(query_name)

      attrs = result.original_hash.dig('data', query_name)

      new(attrs)
    end

    def graphql_scope(scope_name)
      define_singleton_method scope_name.to_sym, ->(fragment: "...#{name}::Fragments::Default", limit: nil, objects_per_query: 50, **variables) do
        string_scope_name = scope_name.to_s
        results = []
        cursor = nil

        # Only ask for a limited number of objects in case the limit is below the threshold
        if limit && limit < objects_per_query
          objects_per_query = limit
        end

        loop do
          result = execute_graphql_query(
            query_template: "#{name}::Queries::#{string_scope_name.camelize}Template".constantize,
            fragment:,
            variables: variables.merge(first: objects_per_query, cursor:).compact,
          )

          raise if result.errors.any?

          results += result.original_hash.dig('data', string_scope_name, 'edges').map { new(_1['node']) }

          break if limit && results.size >= limit
          break unless result.original_hash.dig('data', string_scope_name, 'pageInfo', 'hasNextPage')
        end

        results
      end
    end

    private

    def execute_graphql_query(query_template:, variables:, fragment:)
      ActiveGraphql::Client.query(
        ActiveGraphql::Client.parse(
          format(query_template, fragment:)
        ),
        variables:,
      )
    end
  end
end
