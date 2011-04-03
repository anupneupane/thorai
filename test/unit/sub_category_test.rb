require 'test_helper'

class SubCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert SubCategory.new.valid?
  end
end
