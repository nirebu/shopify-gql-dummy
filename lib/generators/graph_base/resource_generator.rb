# frozen_string_literal: true

module GraphBase
  class ResourceGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def create_resource_files
      template('resource.rb.erb', "app/graphql/#{file_name}_resource.rb")
      template('mutation.rb.erb', "app/graphql/mutations/#{file_name}_mutation.rb")
      template('query.rb.erb', "app/graphql/queries/#{file_name}_query.rb")
    end
  end
end