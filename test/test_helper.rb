ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  include ActiveMerchant::Billing
  # Add more helper methods to be used by all tests here...
  
  def credit_card_hash(options = {})
    {
      :number => '1',
      :first_name => 'Vinaya',
      :last_name => 'Shrestha',
      :month => '11',
      :year => '2015',
      :verification_value => '559',
      :type => 'discover'
    }.update(options)
  end
  
  def credit_card(options = {})
    ActiveMerchant::Billing::CreditCard.new(credit_card_hash(options))
  end
  
  def address(options = {})
    {
      :name => 'Vinaya Shrestha',
      :address1 => '1408 11th St S',
      :address2 => 'M',
      :city => 'Birmingham',
      :state => 'AL',
      :country => 'US',
      :zip => '35205'
    }.update(options)
  end
  
end
