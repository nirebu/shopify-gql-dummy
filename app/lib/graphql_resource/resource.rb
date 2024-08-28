# frozen_string_literal: true

class GraphqlResource::Resource
  class << self
    def generate(name)
      type = load_type(name)
      default_fragment = build_default_fragment(type)
      queries = load_queries(type)
      # mutations = load_mutations(name)
    end

    def load_type(name)
      ShopifyGqlApi::Client.schema.types[name]
    end

    def build_default_fragment(type)
      <<~GRAPHQL.squish
        fragment #{type.graphql_name}::Fragments::Default on #{type.name} {
          #{type.fields.filter_map { |name, field| name if field.connection? }.join("\n")}
        }
      GRAPHQL
    end

    def load_queries(type)
      queries = ShopifyGqlApi::Client.schema.types['QueryRoot'].fields
      finder_query = queries[type.graphql_name.downcase_first]
      where_query = queries[type.graphql_name.downcase_first.pluralize]
      # queries_returning_type = []
      # queries_returning_type_connection = []
      # other_queries_returning_type = queries.each do |name, query|
      #   if query.type.respond_to?(:of_type)
      #     queries_returning_type_connection << query if query.type.of_type.graphql_name == "#{type.graphql_name}Connection"
      #   elsif query.type.graphql_name == type.graphql_name
      #     queries_returning_type << query
      #   end
      # end

      binding.irb
    end
  end
end
