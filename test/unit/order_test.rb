require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Order.new.valid?
  end
  
  def test_successful_order_authorization
    order = orders(:pending)
    credit_card = credit_card(:number => '1')
    
    assert_difference 'order.transactions.count' do
      authorization = order.authorize_payment(credit_card)
      assert_equal authorization.reference, order.authorization_reference
      assert authorization.success?
      assert order.authorized?
    end
  end
  
  def test_failed_order_authorization
    order = orders(:pending)
    credit_card = credit_card(:number => '2')
    
    assert_difference 'order.transactions.count' do
      authorization = order.authorize_payment(credit_card)
      assert_nil order.authorization_reference
      assert !authorization.success?
      assert order.payment_declined?
    end
  end

  def test_exception_raised_during_authorization
    order = orders(:pending)
    credit_card = credit_card(:number => '3')
    
    assert_difference 'order.transactions.count' do
      authorization = order.authorize_payment(credit_card)
      assert_nil order.authorization_reference
      assert !authorization.success?
      assert order.payment_declined?
    end
  end
  
  def test_successful_payment_capture 
    order = orders(:authorized)
    assert_difference ‘order.transactions.count’ do 
      capture = order.capture_payment 
      assert order.paid? 
      assert capture.success?
    end 
  end
  
  def test_failed_payment_capture 
    order = orders(:uncapturable)
    assert_difference ‘order.transactions.count’ do 
      capture = order.capture_payment 
      assert order.authorized? 
      assert !capture.success?
    end
  end
  
  def test_error_during_payment_capture
    order = orders(:uncapturable_error)
    assert_difference ‘order.transactions.count’ do 
      capture = order.capture_payment 
      assert order.authorized? 
      assert !capture.success?
    end
  end
  
end
