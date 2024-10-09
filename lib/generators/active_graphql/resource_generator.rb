# frozen_string_literal: true

module GraphqlResource
  class ResourceGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def create_resource_files
      resource = GraphqlResource::Resource.load_from_schema_type(name)

      template(
        "fragment.rb.erb",
        "app/models/#{name.underscore}/fragments/default.rb",
        default_fragment_fields: resource.default_fragment_fields
      )
      resource.queries_returning_type.each do |query|
        config = {
          wrapper_signature: wrapper_signature(query),
          internal_signature: internal_signature(query),
          module_name: query.graphql_name.upcase_first,
          graphql_query_name: query.graphql_name,
        }
        template(
          "query_returning_type.rb.erb",
          "app/models/#{name.underscore}/queries/#{query.graphql_name.underscore}_query_template.rb",
          config,
        )
        template(
          "attributes.rb.erb",
          "app/models/#{name.underscore}/attributes.rb",
          attributes: resource.default_fragment_fields.map { ":#{_1}" }
        )
      end

      resource.queries_returning_type_connection.each do |query|
        config = {
          wrapper_signature: wrapper_signature(query),
          internal_signature: internal_signature(query),
          module_name: query.graphql_name.upcase_first,
          graphql_query_name: query.graphql_name,
        }
        template(
          "query_returning_type_connection.rb.erb",
          "app/models/#{name.underscore}/queries/#{query.graphql_name.underscore}_query_template.rb",
          config,
        )
      end
    end

    private

    def wrapper_signature(query)
      query.arguments.map do |argument_name, argument|
        "#{argument_name}: #{argument.type.to_type_signature}"
      end.join(", ")
    end

    def internal_signature(query)
      query.arguments.map do |argument_name, argument|
        "#{argument_name}: $#{argument_name}"
      end.join(", ")
    end
  end
end
