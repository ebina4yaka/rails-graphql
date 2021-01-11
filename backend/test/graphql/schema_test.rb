require 'test_helper'

class SchemaTest < ActiveSupport::TestCase
  test 'dumped_schema' do
    current_definition = BackendSchema.to_definition
    printout_definition = File.read(Rails.root.join('schema.graphql'))

    assert_equal(current_definition, printout_definition)
  end
end
