require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  include Image

  test 'create_extension_from_base64_text' do
    base64_jpeg = 'data:image/jpeg;base64,example/base64/encoded/text/value/ABC/DEF'
    assert_equal('jpeg', create_extension(base64_jpeg))
    base64_png = 'data:image/png;base64,example/base64/encoded/text/value/ABC/DEF'
    assert_equal('png', create_extension(base64_png))
  end
end
