require "test_helper"
require "generators/saadb/saadb_generator"

class SaadbGeneratorTest < Rails::Generators::TestCase
  tests SaadbGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
