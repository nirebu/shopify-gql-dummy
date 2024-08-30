# frozen_string_literal: true

class GraphqlResource::Resource
  class << self
    def load_from_schema_type(name)
      type = load_type(name)
      connections = []
      default_fragment_fields = []
      type.fields.each do |name, field|
        if field.connection?
          connections << name
        else
          default_fragment_fields << name
        end
      end
      queries_returning_type, queries_returning_type_connection = load_queries(type)
      # mutations = load_mutations(name)
      new(name: name, queries_returning_type: queries_returning_type, queries_returning_type_connection: queries_returning_type_connection, default_fragment_fields: default_fragment_fields, connections: connections)
    end

    def load_type(name)
      GraphqlResource::Client.schema.types[name]
    end

    def load_queries(type)
      all_schema_queries = GraphqlResource::Client.schema.types['QueryRoot'].fields
      queries_returning_type = []
      queries_returning_type_connection = []
      binding.irb
      all_schema_queries.each do |_name, query|
        if query.type.to_type_signature == "#{type.graphql_name}Connection"
          queries_returning_type_connection << query
        elsif query.type.to_type_signature == type.graphql_name
          queries_returning_type << query
        end
      end
      [queries_returning_type, queries_returning_type_connection]
    end
  end

  attr_reader :name, :queries_returning_type, :queries_returning_type_connection, :default_fragment_fields, :connections

  def initialize(name:, queries_returning_type:, queries_returning_type_connection:, default_fragment_fields:, connections:)
    @name = name
    @queries_returning_type = queries_returning_type
    @queries_returning_type_connection = queries_returning_type_connection
    @default_fragment_fields = default_fragment_fields
    @connections = connections
  end
end
