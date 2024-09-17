# frozen_string_literal: true

module GraphqlResource::FinderMethods
  extend ActiveSupport::Concern

  class_methods do
    def find(id, fragment: "...#{name}::Fragments::Default")
      result = ShopifyGqlApi::Client.query(
        ShopifyGqlApi::Client.parse(format(name.constantize::Queries::Templates::Find, fragment: fragment)),
        variables: { id: id }
      )

      raise result.errors.to_s if result.errors.any?
      raise NotFoundError unless result.data.public_send(name.underscore)

      result.data.public_send(name.underscore)
    end

    def where(query, fragment: "...#{name}::Fragments::Default", objects_per_query: 50, limit: nil)
      objects_per_query = limit if limit && limit < objects_per_query

      results = []
      end_cursor = nil

      loop do
        result = ShopifyGqlApi::Client.query(
          ShopifyGqlApi::Client.parse(format(name.constantize::Queries::Templates::Where, fragment: fragment)),
          variables: { query: query, objects_per_query: objects_per_query, cursor: end_cursor }
        )

        raise result.errors.to_s if result.errors.any?

        results += result.data.public_send(name.underscore.pluralize).edges.map(&:node)
        if (limit && results.size >= limit) || !result.data.public_send(name.underscore.pluralize).page_info.has_next_page
          break results
        end
        end_cursor = result.data.public_send(name.underscore.pluralize).page_info.end_cursor
      end
    end
  end
end
