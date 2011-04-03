require 'test_helper'

class DailyDealMailingTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert DailyDealMailing.new.valid?
  end
end
